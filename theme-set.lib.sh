#!/bin/bash

# Shared library for the Omarchy theme hook.
#
# Both the theme-set hook and every hooklette in theme-set.d source this file,
# because Omarchy 4's omarchy-hook runs each hooklette as its own process
# instead of as a child of theme-set, so exported functions and colors are not
# in scope there.

[[ -n "${THEME_HOOK_LIB_SOURCED:-}" ]] && return 0
THEME_HOOK_LIB_SOURCED=1

success() {
    echo -e "\e[32m[SUCCESS]\e[0m $1"
}

skipped() {
    echo -e "\033[0;34m[SKIPPED]\e[0m $1 not found. Skipping.."
    exit 0
}

warning() {
    echo -e "\033[0;33m[WARNING]\e[0m $1"
}

error() {
    echo -e "\e[31m[ERROR]\e[0m $1" >&2
    exit 1
}

# omarchy-hook executes every file in theme-set.d regardless of its permissions,
# so hooklettes disabled through `thctl disable` (chmod -x) have to bail here.
hooklette="${BASH_SOURCE[1]:-}"
if [[ $hooklette == */theme-set.d/* && -f $hooklette && ! -x $hooklette ]]; then
    exit 0
fi
unset hooklette

# Omarchy 4 moved the current theme pointer to ~/.local/state, Omarchy 3 keeps
# it in ~/.config. The stale ~/.config directory survives the upgrade, so the
# theme directory is resolved by looking for colors.toml rather than by testing
# whether the directory exists.
resolve_theme_dir() {
    local dir
    for dir in "$HOME/.local/state/omarchy/current/theme" "$HOME/.config/omarchy/current/theme"; do
        if [[ -f "$dir/colors.toml" ]]; then
            printf '%s\n' "$dir"
            return 0
        fi
    done
    return 1
}

if [[ -z "${omarchy_theme_dir:-}" ]]; then
    omarchy_theme_dir=$(resolve_theme_dir) ||
        error "colors.toml not found in ~/.local/state/omarchy/current/theme or ~/.config/omarchy/current/theme. Ensure your theme is compatible with Omarchy 3.3+ and includes colors.toml."
fi
colors_file="$omarchy_theme_dir/colors.toml"
export omarchy_theme_dir colors_file

hex2rgb() {
    local hex_input="${1#\#}"
    [[ $hex_input =~ ^[0-9a-fA-F]{6}$ ]] || error "Invalid hex color \"$1\" read from $colors_file."
    printf '%d, %d, %d\n' "$((16#${hex_input:0:2}))" "$((16#${hex_input:2:2}))" "$((16#${hex_input:4:2}))"
}

rgb2hex() {
    printf "%02x%02x%02x" "$1" "$2" "$3"
}

change_shade() {
    local hex_input="${1#\#}"
    local shade=$2
    [[ $hex_input =~ ^[0-9a-fA-F]{6}$ ]] || error "Invalid hex color \"$1\" read from $colors_file."

    local channel value shifted=()
    for channel in "${hex_input:0:2}" "${hex_input:2:2}" "${hex_input:4:2}"; do
        value=$((16#$channel + shade))
        ((value < 0)) && value=0
        ((value > 255)) && value=255
        shifted+=("$value")
    done

    rgb2hex "${shifted[@]}"
}

restart_file="${THEME_HOOK_RESTART_FILE:-${XDG_RUNTIME_DIR:-/tmp}/omarchy-theme-hook.restart}"
export restart_file

require_restart() {
    echo "$1" >> "$restart_file"
}

# Read every color in a single pass; each hooklette runs in its own process and
# would otherwise spawn an awk per color.
#
# Two generations of colors.toml exist: themes from the Omarchy 4.5+ gallery
# use named keys (red, green, cyan, ...), while Omarchy <= 4.4 themes and git
# themes use the legacy 16-color block (color0..color15). Read both, then
# resolve each slot from the named key with the legacy key as fallback.
load_theme_colors() {
    local key hex

    # Discard values from a previous load when the library is re-sourced.
    unset primary_foreground primary_background cursor_color \
        selection_foreground selection_background \
        c_red c_green c_yellow c_blue c_magenta c_cyan \
        c_dark_foreground c_bright_foreground \
        c_bright_red c_bright_green c_bright_yellow c_bright_blue c_bright_magenta c_bright_cyan \
        x_black x_red x_green x_yellow x_blue x_magenta x_cyan x_white \
        x_bright_black x_bright_red x_bright_green x_bright_yellow x_bright_blue x_bright_magenta x_bright_cyan

    while IFS='=' read -r key hex; do
        case "$key" in
            foreground) primary_foreground=$hex ;;
            background) primary_background=$hex ;;
            cursor) cursor_color=$hex ;;
            selection_foreground) selection_foreground=$hex ;;
            selection_background) selection_background=$hex ;;
            # Omarchy 4.5+ named keys
            red) c_red=$hex ;;
            green) c_green=$hex ;;
            yellow) c_yellow=$hex ;;
            blue) c_blue=$hex ;;
            magenta) c_magenta=$hex ;;
            cyan) c_cyan=$hex ;;
            dark_foreground) c_dark_foreground=$hex ;;
            bright_foreground) c_bright_foreground=$hex ;;
            bright_red) c_bright_red=$hex ;;
            bright_green) c_bright_green=$hex ;;
            bright_yellow) c_bright_yellow=$hex ;;
            bright_blue) c_bright_blue=$hex ;;
            bright_magenta) c_bright_magenta=$hex ;;
            bright_cyan) c_bright_cyan=$hex ;;
            # Legacy 16-color keys
            color0) x_black=$hex ;;
            color1) x_red=$hex ;;
            color2) x_green=$hex ;;
            color3) x_yellow=$hex ;;
            color4) x_blue=$hex ;;
            color5) x_magenta=$hex ;;
            color6) x_cyan=$hex ;;
            color7) x_white=$hex ;;
            color8) x_bright_black=$hex ;;
            color9) x_bright_red=$hex ;;
            color10) x_bright_green=$hex ;;
            color11) x_bright_yellow=$hex ;;
            color12) x_bright_blue=$hex ;;
            color13) x_bright_magenta=$hex ;;
            color14) x_bright_cyan=$hex ;;
            color15) x_bright_white=$hex ;;
        esac
    done < <(awk '
        /=/ && match($0, /#[0-9a-fA-F]{6}/) && seen[$1]++ == 0 {
            print $1 "=" substr($0, RSTART + 1, 6)
        }
    ' "$colors_file")

    # Resolve each slot: named key first, legacy key as fallback. The last
    # resort maps black to the background and white to the foreground, the way
    # base16 themes treat them.
    normal_red=${c_red:-${x_red:-}}
    normal_green=${c_green:-${x_green:-}}
    normal_yellow=${c_yellow:-${x_yellow:-}}
    normal_blue=${c_blue:-${x_blue:-}}
    normal_magenta=${c_magenta:-${x_magenta:-}}
    normal_cyan=${c_cyan:-${x_cyan:-}}
    normal_black=${x_black:-$primary_background}
    normal_white=${x_white:-${c_bright_foreground:-$primary_foreground}}
    bright_black=${x_bright_black:-${c_dark_foreground:-$normal_black}}
    bright_red=${c_bright_red:-${x_bright_red:-$normal_red}}
    bright_green=${c_bright_green:-${x_bright_green:-$normal_green}}
    bright_yellow=${c_bright_yellow:-${x_bright_yellow:-$normal_yellow}}
    bright_blue=${c_bright_blue:-${x_bright_blue:-$normal_blue}}
    bright_magenta=${c_bright_magenta:-${x_bright_magenta:-$normal_magenta}}
    bright_cyan=${c_bright_cyan:-${x_bright_cyan:-$normal_cyan}}
    bright_white=${x_bright_white:-${c_bright_foreground:-$primary_foreground}}

    local missing=()
    local name
    for name in primary_foreground primary_background \
        normal_black normal_red normal_green normal_yellow \
        normal_blue normal_magenta normal_cyan normal_white \
        bright_black bright_red bright_green bright_yellow \
        bright_blue bright_magenta bright_cyan bright_white; do
        [[ -n ${!name} ]] || missing+=("$name")
    done

    if ((${#missing[@]} > 0)); then
        error "No color found for ${missing[*]} in $colors_file. Ensure your theme defines its palette (named keys or color0..color15)."
    fi

    # Optional keys fall back to the primary colors, as themes may omit them.
    : "${cursor_color:=$primary_foreground}"
    : "${selection_foreground:=$primary_background}"
    : "${selection_background:=$primary_foreground}"

    rgb_primary_foreground=$(hex2rgb "$primary_foreground")
    rgb_primary_background=$(hex2rgb "$primary_background")
    rgb_normal_black=$(hex2rgb "$normal_black")
    rgb_normal_red=$(hex2rgb "$normal_red")
    rgb_normal_green=$(hex2rgb "$normal_green")
    rgb_normal_yellow=$(hex2rgb "$normal_yellow")
    rgb_normal_blue=$(hex2rgb "$normal_blue")
    rgb_normal_magenta=$(hex2rgb "$normal_magenta")
    rgb_normal_cyan=$(hex2rgb "$normal_cyan")
    rgb_normal_white=$(hex2rgb "$normal_white")
    rgb_bright_black=$(hex2rgb "$bright_black")
    rgb_bright_red=$(hex2rgb "$bright_red")
    rgb_bright_green=$(hex2rgb "$bright_green")
    rgb_bright_yellow=$(hex2rgb "$bright_yellow")
    rgb_bright_blue=$(hex2rgb "$bright_blue")
    rgb_bright_magenta=$(hex2rgb "$bright_magenta")
    rgb_bright_cyan=$(hex2rgb "$bright_cyan")
    rgb_bright_white=$(hex2rgb "$bright_white")
}

# The generated file of a hooklette is an output, not a source: regenerate it
# from colors.toml on every run. Write to a temporary file and validate before
# publishing, so a failure (or an interrupted run) leaves the previous good
# file in place instead of a half-written or empty-color one.
publish_generated_file() {
    local target=$1 tmp=$2 invalid

    # Every @define-color statement must resolve: a 6-digit hex value, another
    # color name, or alpha() of one; anything else means an unresolved
    # variable slipped in.
    invalid=$(grep -E '^[[:space:]]*@define-color' "$tmp" | grep -vE '#[0-9a-fA-F]{6};|@[a-zA-Z_]+;|alpha\([^)]*\);')
    if [[ -n $invalid ]] || grep -q '#;' "$tmp"; then
        error "Generated file $target contains invalid colors, keeping the existing one. Offending lines: ${invalid//$'\n'/ | }"
    fi

    [[ -f $target ]] || touch "$target"
    mv -f "$tmp" "$target"
}

load_theme_colors

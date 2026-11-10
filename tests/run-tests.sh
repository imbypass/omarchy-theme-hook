#!/bin/bash
# Regression tests for the Omarchy theme hook (Omarchy 4.x compatible).
#
# Each test runs against a sandboxed HOME, so nothing outside the sandbox is
# touched. Stubs replace the desktop commands the hooklettes invoke.

set -u

REPO_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
PASSED=0
FAILED=0

report() {
    if (($2 == 0)); then
        echo "  PASS: $1"
        PASSED=$((PASSED + 1))
    else
        echo "  FAIL: $1"
        FAILED=$((FAILED + 1))
    fi
}

make_sandbox() {
    local sandbox=$1

    mkdir -p "$sandbox"/{bin,.config/omarchy/hooks/theme-set.d,.local/state/omarchy/current/theme,.config/gtk-3.0,.config/gtk-4.0,.config/vesktop/themes}

    cp "$REPO_DIR/theme-set.lib.sh" "$sandbox/.config/omarchy/hooks/"
    cp "$REPO_DIR"/theme-set.d/*.sh "$sandbox/.config/omarchy/hooks/theme-set.d/"
    cp "$REPO_DIR/theme-set" "$sandbox/.config/omarchy/hooks/"

    # Desktop command stubs.
    for cmd in gsettings pkill notify-send vicinae; do
        printf '#!/bin/bash\nexit 0\n' > "$sandbox/bin/$cmd"
        chmod +x "$sandbox/bin/$cmd"
    done
    # A theme-color stub is installed per test when needed.
}

legacy_colors_toml() {
    cat << 'EOF'
accent = "#7daea3"
cursor = "#d4be98"
foreground = "#d4be98"
background = "#282828"
selection_foreground = "#282828"
selection_background = "#7daea3"

color0 = "#3c3836"
color1 = "#ea6962"
color2 = "#a9b665"
color3 = "#d8a657"
color4 = "#7daea3"
color5 = "#d3869b"
color6 = "#89b482"
color7 = "#d4be98"
color8 = "#928374"
color9 = "#ea6962"
color10 = "#a9b665"
color11 = "#d8a657"
color12 = "#7daea3"
color13 = "#d3869b"
color14 = "#89b482"
color15 = "#d4be98"
EOF
}

named_colors_toml() {
    cat << 'EOF'
mode = "dark"

accent = "#89b4fa"
selection = "#45475a"
muted = "#585b70"

background = "#1e1e2e"
dark_background = "#161622"
foreground = "#cdd6f4"
dark_foreground = "#6c7086"
bright_foreground = "#cdd6f4"

red = "#f38ba8"
yellow = "#f9e2af"
green = "#a6e3a1"
cyan = "#94e2d5"
blue = "#89b4fa"
magenta = "#f5c2e7"

bright_red = "#f38ba8"
bright_yellow = "#f9e2af"
bright_green = "#a6e3a1"
bright_cyan = "#94e2d5"
bright_blue = "#89b4fa"
bright_magenta = "#f5c2e7"
EOF
}

# Run a hooklette the way omarchy-hook does: a bare bash process whose only
# inheritance is the environment we give it (no exported hook functions).
run_hooklette() {
    local sandbox=$1 hooklette=$2
    shift 2
    env -i HOME="$sandbox" PATH="$sandbox/bin:/usr/bin:/bin" \
        bash "$sandbox/.config/omarchy/hooks/theme-set.d/$hooklette" "$@"
}

# ---------------------------------------------------------------- test cases

test_legacy_colors() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    legacy_colors_toml > "$sandbox/.local/state/omarchy/current/theme/colors.toml"

    local out
    out=$(env -i HOME="$sandbox" PATH="$sandbox/bin:/usr/bin:/bin" \
        bash -c 'source '"$sandbox"'/.config/omarchy/hooks/theme-set.lib.sh; printf "%s %s %s %s" "$primary_background" "$normal_red" "$bright_black" "$normal_white"') \
        && report "lib loads legacy color0-15 palette" 0 || report "lib loads legacy color0-15 palette" 1

    [[ $out == "282828 ea6962 928374 d4be98" ]] \
        && report "legacy colors resolve correctly ($out)" 0 || report "legacy colors resolve correctly (got: $out)" 1
    rm -rf "$sandbox"
}

test_named_colors() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    named_colors_toml > "$sandbox/.local/state/omarchy/current/theme/colors.toml"

    local out
    out=$(env -i HOME="$sandbox" PATH="$sandbox/bin:/usr/bin:/bin" \
        bash -c 'source '"$sandbox"'/.config/omarchy/hooks/theme-set.lib.sh; printf "%s %s %s %s" "$primary_background" "$normal_red" "$bright_black" "$normal_white"') \
        && report "lib loads Omarchy 4.5 named palette" 0 || report "lib loads Omarchy 4.5 named palette" 1

    [[ $out == "1e1e2e f38ba8 6c7086 cdd6f4" ]] \
        && report "named colors resolve correctly ($out)" 0 || report "named colors resolve correctly (got: $out)" 1
    rm -rf "$sandbox"
}

test_mixed_colors_named_priority() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    { named_colors_toml; echo 'color1 = "#0000ff"'; } > "$sandbox/.local/state/omarchy/current/theme/colors.toml"

    local out
    out=$(env -i HOME="$sandbox" PATH="$sandbox/bin:/usr/bin:/bin" \
        bash -c 'source '"$sandbox"'/.config/omarchy/hooks/theme-set.lib.sh; printf "%s" "$normal_red"')
    [[ $out == "f38ba8" ]] \
        && report "named key wins over legacy color1" 0 || report "named key wins over legacy color1 (got: $out)" 1
    rm -rf "$sandbox"
}

test_invalid_color_fails() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    { legacy_colors_toml; echo 'background = "notacolor"'; } > "$sandbox/.local/state/omarchy/current/theme/colors.toml"
    # Drop the valid background line so the invalid one is the only background.
    sed -i '0,/^background = "#282828"$/{/^background = "#282828"$/d}' "$sandbox/.local/state/omarchy/current/theme/colors.toml"

    if env -i HOME="$sandbox" PATH="$sandbox/bin:/usr/bin:/bin" \
        bash -c 'source '"$sandbox"'/.config/omarchy/hooks/theme-set.lib.sh' >/dev/null 2>&1; then
        report "invalid color value is rejected" 1
    else
        report "invalid color value is rejected" 0
    fi
    rm -rf "$sandbox"
}

test_missing_colors_toml_fails() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"

    if env -i HOME="$sandbox" PATH="$sandbox/bin:/usr/bin:/bin" \
        bash -c 'source '"$sandbox"'/.config/omarchy/hooks/theme-set.lib.sh' >/dev/null 2>&1; then
        report "missing colors.toml is fatal" 1
    else
        report "missing colors.toml is fatal" 0
    fi
    rm -rf "$sandbox"
}

test_state_dir_wins_over_legacy() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    mkdir -p "$sandbox/.config/omarchy/current/theme"
    legacy_colors_toml > "$sandbox/.local/state/omarchy/current/theme/colors.toml"
    # Stale legacy copy of an older theme must be ignored when the state
    # directory has the current one.
    legacy_colors_toml | sed 's/^background = "#282828"$/background = "#000000"/' \
        > "$sandbox/.config/omarchy/current/theme/colors.toml"

    local out
    out=$(env -i HOME="$sandbox" PATH="$sandbox/bin:/usr/bin:/bin" \
        bash -c 'source '"$sandbox"'/.config/omarchy/hooks/theme-set.lib.sh; printf "%s" "$primary_background"')
    [[ $out == "282828" ]] \
        && report "state theme dir wins over stale legacy dir" 0 || report "state theme dir wins over stale legacy dir (got: $out)" 1
    rm -rf "$sandbox"
}

test_gtk_regen_heals_poison() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    local theme_dir="$sandbox/.local/state/omarchy/current/theme"
    legacy_colors_toml > "$theme_dir/colors.toml"

    # Simulate the historical corruption: poisoned outputs everywhere.
    printf '@define-color background #;\n' > "$theme_dir/gtk.css"
    printf '@define-color background #;\n' > "$sandbox/.config/gtk-4.0/gtk.css"
    printf '@define-color background #;\n' > "$sandbox/.config/gtk-3.0/gtk.css"

    run_hooklette "$sandbox" 10-gtk.sh > /dev/null 2>&1

    if ! grep -q '#;' "$theme_dir/gtk.css" && grep -q '@define-color background     #282828;' "$theme_dir/gtk.css"; then
        report "poisoned gtk.css is regenerated from colors.toml" 0
    else
        report "poisoned gtk.css is regenerated from colors.toml" 1
    fi

    ! grep -q '#;' "$sandbox/.config/gtk-4.0/gtk.css" \
        && report "GTK4 css published valid" 0 || report "GTK4 css published valid" 1
    ! grep -q '#;' "$sandbox/.config/gtk-3.0/gtk.css" \
        && report "GTK3 css published valid" 0 || report "GTK3 css published valid" 1
    rm -rf "$sandbox"
}

test_gtk_idempotent() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    local theme_dir="$sandbox/.local/state/omarchy/current/theme"
    legacy_colors_toml > "$theme_dir/colors.toml"

    run_hooklette "$sandbox" 10-gtk.sh > /dev/null 2>&1
    local first; first=$(cat "$theme_dir/gtk.css")
    run_hooklette "$sandbox" 10-gtk.sh > /dev/null 2>&1
    local second; second=$(cat "$theme_dir/gtk.css")

    [[ $first == "$second" && -n $first ]] \
        && report "gtk hooklette is idempotent" 0 || report "gtk hooklette is idempotent" 1
    rm -rf "$sandbox"
}

test_gtk_backup_preserved() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    local theme_dir="$sandbox/.local/state/omarchy/current/theme"
    legacy_colors_toml > "$theme_dir/colors.toml"
    printf '/* user custom css */\n' > "$sandbox/.config/gtk-4.0/gtk.css"

    run_hooklette "$sandbox" 10-gtk.sh > /dev/null 2>&1

    grep -q 'user custom css' "$sandbox/.config/gtk-4.0/gtk.css.backup" \
        && report "pre-hook user gtk.css is backed up once" 0 || report "pre-hook user gtk.css is backed up once" 1
    rm -rf "$sandbox"
}

test_disabled_hooklette_noop() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    local theme_dir="$sandbox/.local/state/omarchy/current/theme"
    legacy_colors_toml > "$theme_dir/colors.toml"
    chmod -x "$sandbox/.config/omarchy/hooks/theme-set.d/10-gtk.sh"

    run_hooklette "$sandbox" 10-gtk.sh > /dev/null 2>&1
    local rc=$?

    [[ $rc -eq 0 && ! -f "$theme_dir/gtk.css" ]] \
        && report "disabled (chmod -x) hooklette no-ops" 0 || report "disabled (chmod -x) hooklette no-ops (rc=$rc)" 1
    rm -rf "$sandbox"
}

test_discord_regenerates() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    local theme_dir="$sandbox/.local/state/omarchy/current/theme"
    legacy_colors_toml > "$theme_dir/colors.toml"
    printf '/* stale poison */ --color00: #;\n' > "$theme_dir/vencord.theme.css"

    run_hooklette "$sandbox" 10-discord.sh > /dev/null 2>&1

    ! grep -q '#;' "$theme_dir/vencord.theme.css" \
        && grep -q -- '--color00: #282828;' "$theme_dir/vencord.theme.css" \
        && report "stale vencord theme is regenerated" 0 || report "stale vencord theme is regenerated" 1
    grep -q -- '--color00: #282828;' "$sandbox/.config/vesktop/themes/vencord.theme.css" \
        && report "vesktop theme deployed" 0 || report "vesktop theme deployed" 1
    rm -rf "$sandbox"
}

test_parent_single_dispatch_via_omarchy_hook() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    local theme_dir="$sandbox/.local/state/omarchy/current/theme"
    legacy_colors_toml > "$theme_dir/colors.toml"

    # A counting hooklette records every execution.
    printf '#!/bin/bash\nsource "%s/.config/omarchy/hooks/theme-set.lib.sh"\necho run >> "%s/counter"\n' \
        "$sandbox" "$sandbox" > "$sandbox/.config/omarchy/hooks/theme-set.d/00-count.sh"
    chmod +x "$sandbox/.config/omarchy/hooks/theme-set.d/00-count.sh"

    if command -v omarchy-hook >/dev/null 2>&1; then
        env -i HOME="$sandbox" PATH="$sandbox/bin:/usr/bin:/bin" \
            omarchy-hook theme-set testtheme > /dev/null 2>&1
        local count; count=$(wc -l < "$sandbox/counter" 2>/dev/null || echo 0)
        [[ $count -eq 1 ]] \
            && report "hooklette runs exactly once under omarchy-hook (count=$count)" 0 \
            || report "hooklette runs exactly once under omarchy-hook (count=$count)" 1
    else
        echo "  SKIP: omarchy-hook not available"
    fi
    rm -rf "$sandbox"
}

test_parent_manual_run_dispatches() {
    local sandbox; sandbox=$(mktemp -d)
    make_sandbox "$sandbox"
    local theme_dir="$sandbox/.local/state/omarchy/current/theme"
    legacy_colors_toml > "$theme_dir/colors.toml"

    printf '#!/bin/bash\nsource "%s/.config/omarchy/hooks/theme-set.lib.sh"\necho run >> "%s/counter"\n' \
        "$sandbox" "$sandbox" > "$sandbox/.config/omarchy/hooks/theme-set.d/00-count.sh"
    chmod +x "$sandbox/.config/omarchy/hooks/theme-set.d/00-count.sh"

    # Run theme-set by hand: the parent owns the dispatch then.
    env -i HOME="$sandbox" PATH="$sandbox/bin:/usr/bin:/bin" \
        bash "$sandbox/.config/omarchy/hooks/theme-set" manual > /dev/null 2>&1
    local count; count=$(wc -l < "$sandbox/counter" 2>/dev/null || echo 0)
    [[ $count -ge 1 ]] \
        && report "manual theme-set run still dispatches hooklettes" 0 \
        || report "manual theme-set run still dispatches hooklettes" 1
    rm -rf "$sandbox"
}

echo "=== omarchy-theme-hook regression tests ==="
test_legacy_colors
test_named_colors
test_mixed_colors_named_priority
test_invalid_color_fails
test_missing_colors_toml_fails
test_state_dir_wins_over_legacy
test_gtk_regen_heals_poison
test_gtk_idempotent
test_gtk_backup_preserved
test_disabled_hooklette_noop
test_discord_regenerates
test_parent_single_dispatch_via_omarchy_hook
test_parent_manual_run_dispatches

echo
echo "=== Results: $PASSED passed, $FAILED failed ==="
(( FAILED == 0 ))

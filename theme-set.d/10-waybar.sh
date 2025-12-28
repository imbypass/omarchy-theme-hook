#!/bin/bash

THEME_NAME="${1:-}"
THEME_DIR="$HOME/.config/omarchy/themes/$THEME_NAME"
WAYBAR_THEME_DIR="$THEME_DIR/waybar-theme"
WAYBAR_DIR="$HOME/.config/waybar"
DEFAULT_WAYBAR_DIR="$HOME/.local/share/omarchy/config/waybar"
BACKUP_ROOT="$HOME/.config/waybar-backups"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S)"

restore_waybar_defaults() {
    if [[ ! -d "$DEFAULT_WAYBAR_DIR" ]]; then
        return 0
    fi

    mkdir -p "$WAYBAR_DIR"
    for file in config.jsonc style.css; do
        if [[ -L "$WAYBAR_DIR/$file" ]]; then
            rm -f "$WAYBAR_DIR/$file"
        fi
        if [[ -e "$DEFAULT_WAYBAR_DIR/$file" ]]; then
            ln -snf "$DEFAULT_WAYBAR_DIR/$file" "$WAYBAR_DIR/$file"
        fi
    done

    if pgrep -x waybar >/dev/null; then
        omarchy-restart-waybar
    fi
}

if [[ -n "$THEME_NAME" && -d "$WAYBAR_THEME_DIR" ]]; then
    mkdir -p "$WAYBAR_DIR" "$BACKUP_DIR" "$BACKUP_ROOT"

    for file in config.jsonc style.css; do
        if [[ -L "$WAYBAR_DIR/$file" ]]; then
            rm -f "$WAYBAR_DIR/$file"
        elif [[ -e "$WAYBAR_DIR/$file" ]]; then
            cp -a "$WAYBAR_DIR/$file" "$BACKUP_DIR/$file"
        fi

        if [[ -e "$WAYBAR_THEME_DIR/$file" ]]; then
            ln -snf "$WAYBAR_THEME_DIR/$file" "$WAYBAR_DIR/$file"
        fi
    done

    if pgrep -x waybar >/dev/null; then
        omarchy-restart-waybar
    fi

    exit 0
fi

restore_waybar_defaults

output_file="$HOME/.config/omarchy/current/theme/waybar.css"

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
@define-color black #${normal_black};
@define-color red #${normal_red};
@define-color green #${normal_green};
@define-color yellow #${normal_yellow};
@define-color blue #${normal_blue};
@define-color magenta #${normal_magenta};
@define-color cyan #${normal_cyan};
@define-color white #${normal_white};
@define-color bright_black #${bright_black};
@define-color bright_red #${bright_red};
@define-color bright_green #${bright_green};
@define-color bright_yellow #${bright_yellow};
@define-color bright_blue #${bright_blue};
@define-color bright_magenta #${bright_magenta};
@define-color bright_cyan #${bright_cyan};
@define-color bright_white #${bright_white};
@define-color background #${primary_background};
@define-color foreground #${primary_foreground};
EOF
fi

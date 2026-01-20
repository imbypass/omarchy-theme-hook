#!/bin/bash
# Sync jellyfin-tui Omarchy theme from Omarchy (kitty) colors
# Called by theme-set hook

THEME="$1"
KITTY_CONF="$HOME/.config/omarchy/current/theme/kitty.conf"
JELLYFIN_CONF="$HOME/.config/jellyfin-tui/config.yaml"

[[ ! -f "$KITTY_CONF" ]] && exit 0
[[ ! -f "$JELLYFIN_CONF" ]] && exit 0

# Extract colors from kitty.conf
get_color() { grep "^${1}\s" "$KITTY_CONF" | awk '{print $2}'; }

accent=$(get_color color2)    # Green — focus / active
focus=$(get_color color4)   # Blue — accent / progress

[[ -z "$focus" || -z "$accent" ]] && exit 0

awk -v focus="$focus" -v accent="$accent" '
  BEGIN { in_theme=0 }

  /^[[:space:]]*- name: "Omarchy"/ {
    in_theme=1
  }

  in_theme && /^[[:space:]]*border_focused:/ {
    sub(/:.*/, ": \"" focus "\"")
  }

  in_theme && /^[[:space:]]*tab_active_foreground:/ {
    sub(/:.*/, ": \"" focus "\"")
  }

  in_theme && /^[[:space:]]*progress_fill:/ {
    sub(/:.*/, ": \"" accent "\"")
  }

  in_theme && /^[[:space:]]*accent:/ {
    sub(/:.*/, ": \"" accent "\"")
  }

  in_theme && /^[[:space:]]*- name:/ && $0 !~ /"Omarchy"/ {
    in_theme=0
  }

  { print }
' "$JELLYFIN_CONF" > "${JELLYFIN_CONF}.tmp" \
  && mv "${JELLYFIN_CONF}.tmp" "$JELLYFIN_CONF"

#!/bin/bash
# Sync tmux colors from Omarchy theme
# Called by theme-set hook

THEME="$1"
KITTY_CONF="$HOME/.config/omarchy/current/theme/kitty.conf"
TMUX_COLORS="$HOME/.config/tmux/theme-colors.conf"

[[ ! -f "$KITTY_CONF" ]] && exit 0

# Extract colors from kitty.conf
get_color() { grep "^${1}\s" "$KITTY_CONF" | awk '{print $2}'; }

bg=$(get_color background)
fg=$(get_color foreground)
color0=$(get_color background)    # Darker surface
color1=$(get_color color1)    # Red
color2=$(get_color color2)    # Green
color3=$(get_color color3)    # Yellow
color4=$(get_color color4)    # Blue
color6=$(get_color color6)    # Cyan (primary accent)
color8=$(get_color color8)    # Bright black/gray

# Generate tmux theme
mkdir -p "$(dirname "$TMUX_COLORS")"
cat > "$TMUX_COLORS" << EOF
# Auto-generated from Omarchy theme: $THEME
# DO NOT EDIT - Changes will be overwritten on theme switch

# Status bar
set -g status-style "bg=$bg,fg=$fg"

# Pane borders
set -g pane-border-style "fg=$color1"
set -g pane-active-border-style "fg=$color2"

# Window list formatting - number on accent, name on surface
set -g window-status-format "#[fg=$bg,bg=$color1] #I #[fg=$fg,bg=$color0] #W "
set -g window-status-current-format "#[fg=$bg,bg=$color2,bold] #I #[fg=$color2,bg=$color0,bold] #W "

# Messages & popups
set -g message-style "bg=$color0,fg=$color2"
set -g popup-style "bg=$bg,fg=$fg"
set -g popup-border-style "fg=$color2"

# Status bar content using theme colors
set -g status-left-length 50  # or any number that fits your session names
set -g status-right-length 50  # or any number that fits your session names
set -g status-left "#[fg=$color6,bold]#{session_name} #[fg=$color4]» "
set -g status-right '#[fg=$color4]| #[fg=$color3]#(whoami)@#H #[fg=$color4]| #(~/.config/tmux/scripts/cpu_status.sh) #[fg=$color4]| #(~/.config/tmux/scripts/ram_status.sh) #[fg=$color4]|#[fg=$fg] %H:%M'
EOF

# Reload tmux if running
pgrep -x tmux >/dev/null && tmux source-file "$TMUX_COLORS" 2>/dev/null || true


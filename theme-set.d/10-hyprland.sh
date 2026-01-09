#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/hyprland.conf"

cat > "$output_file" << EOF
# This file is not a full hyprland configuration.
# It is intended to be included in your main hyprland.conf.

general {
    col.active_border = rgba(${bright_yellow}ff)
    col.inactive_border = rgba(${bright_black}ff)
    border_size = 2
}
EOF

hyprctl reload >/dev/null 2>&1

#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/alacritty.toml"

cat > "$output_file" << EOF
[window]
opacity = 0.9

[colors]
transparent_background_colors = true

[colors.primary]
background  = "#${primary_background}"
foreground  = "#${primary_foreground}"

[colors.normal]
black       = "#${normal_black}"
red         = "#${normal_red}"
green       = "#${normal_green}"
yellow      = "#${normal_yellow}"
blue        = "#${normal_blue}"
magenta     = "#${normal_magenta}"
cyan        = "#${normal_cyan}"
white       = "#${normal_white}"

[colors.bright]
black       = "#${bright_black}"
red         = "#${bright_red}"
green       = "#${bright_green}"
yellow      = "#${bright_yellow}"
blue        = "#${bright_blue}"
magenta     = "#${bright_magenta}"
cyan        = "#${bright_cyan}"
white       = "#${bright_white}"
EOF

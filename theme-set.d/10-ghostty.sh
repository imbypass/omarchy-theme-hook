#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/ghostty.conf"

cat > "$output_file" << EOF
font-family = "$(omarchy-font-current)"
background = #${primary_background}
foreground = #${primary_foreground}
cursor-color = #${cursor_color}
selection-background = #${selection_background}
selection-foreground = #${selection_foreground}

palette = 0=#${normal_black}
palette = 1=#${normal_red}
palette = 2=#${normal_green}
palette = 3=#${normal_yellow}
palette = 4=#${normal_blue}
palette = 5=#${normal_magenta}
palette = 6=#${normal_cyan}
palette = 7=#${normal_white}

palette = 8=#${bright_black}
palette = 9=#${bright_red}
palette = 10=#${bright_green}
palette = 11=#${bright_yellow}
palette = 12=#${bright_blue}
palette = 13=#${bright_magenta}
palette = 14=#${bright_cyan}
palette = 15=#${bright_white}
EOF

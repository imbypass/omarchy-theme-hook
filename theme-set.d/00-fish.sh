#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/colors.fish"

if ! command -v fish >/dev/null 2>&1; then
    skipped "Fish - Colors"
fi

cat > "$output_file" << EOF
set -U background '#${primary_background}'
set -U foreground '#${primary_foreground}'
set -U cursor '#${primary_foreground}'
set -U color0 '#${normal_black}'
set -U color1 '#${normal_red}'
set -U color2 '#${normal_green}'
set -U color3 '#${normal_yellow}'
set -U color4 '#${normal_blue}'
set -U color5 '#${normal_magenta}'
set -U color6 '#${normal_cyan}'
set -U color7 '#${normal_white}'
set -U color8 '#${bright_black}'
set -U color9 '#${bright_red}'
set -U color10 '#${bright_green}'
set -U color11 '#${bright_yellow}'
set -U color12 '#${bright_blue}'
set -U color13 '#${bright_magenta}'
set -U color14 '#${bright_cyan}'
set -U color15 '#${bright_white}'

set -U fish_color_normal normal
set -U fish_color_command green
set -U fish_color_param cyan
set -U fish_pager_color_completion
set -U fish_pager_color_description \$fish_color_quote yellow
set -U fish_pager_color_progress brwhite --background=cyan
set -U fish_color_history_current --bold
EOF

fish source "$output_file"
success "fish colors updated!"

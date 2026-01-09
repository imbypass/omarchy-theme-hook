#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/kitty.conf"

cat > "$output_file" <<EOF
background            #${primary_background}
foreground            #${primary_foreground}

color0  #${normal_black}
color1  #${normal_red}
color2  #${normal_green}
color3  #${normal_yellow}
color4  #${normal_blue}
color5  #${normal_magenta}
color6  #${normal_cyan}
color7  #${normal_white}
color8  #${bright_black}
color9  #${bright_red}
color10 #${bright_green}
color11 #${bright_yellow}
color12 #${bright_blue}
color13 #${bright_magenta}
color14 #${bright_cyan}
color15 #${bright_white}
EOF

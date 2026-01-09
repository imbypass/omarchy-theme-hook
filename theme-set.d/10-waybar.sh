#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/waybar.css"

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

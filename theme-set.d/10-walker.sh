#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/walker.css"

cat > "$output_file" << EOF
@define-color selected-text #${normal_yellow};
@define-color selected-vibrant #${bright_yellow};
@define-color text #${primary_foreground};
@define-color base #${normal_black};
@define-color border #${bright_black};
@define-color foreground #${primary_foreground};
@define-color background #${primary_background};
EOF

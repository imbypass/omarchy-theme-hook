#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/mako.ini"

cat > "$output_file" << EOF
include=~/.local/share/omarchy/default/mako/core.ini

text-color=#${primary_foreground}
border-color=#${primary_foreground}
background-color=#${primary_background}
padding=10
border-size=2
font=$(omarchy-font-current) 12
max-icon-size=32
outer-margin=5
EOF

makoctl reload

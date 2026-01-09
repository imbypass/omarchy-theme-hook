#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/chromium.theme"

cat > "$output_file" << EOF
$(hex2rgb $primary_background)
EOF
exit 0

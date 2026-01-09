#!/bin/bash

new_qt_file="$HOME/.config/omarchy/current/theme/qt6ct.conf"

if ! command -v qt6ct >/dev/null 2>&1; then
    skipped "Qt6ct"
fi

base00=$normal_black
base01=$(change_shade $normal_black 5)
base02=$(change_shade $normal_black 10)
base03=$(change_shade $normal_black 15)
base04=$(change_shade $normal_black 20)
base05=$primary_foreground
base06=$(change_shade $primary_foreground -5)
base07=$(change_shade $primary_foreground -10)
base08=$normal_red
base09=$normal_yellow
base0A=$bright_yellow
base0B=$normal_green
base0C=$normal_cyan
base0D=$normal_blue
base0E=$normal_magenta
base0F=$bright_red

if [ ! -f "$new_qt_file" ]; then
cat > "$new_qt_file" << EOF
[ColorScheme]
active_colors=#ff${base05}, #ff${base01}, #ff${base01}, #ff${base05}, #ff${base03}, #ff${base04}, #ff${base05}, #ff${base06}, #ff${base05}, #ff${base01}, #ff${base00}, #ff${base03}, #ff${base02}, #ff${base05}, #ff${base09}, #ff${base08}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base05}, #8f${base05}
disabled_colors=#ff${base00}, #ff${base01}, #ff${base01}, #ff${base04}, #ff${base03}, #ff${base04}, #ff${base00}, #ff${base00}, #ff${base00}, #ff${base01}, #ff${base00}, #ff${base03}, #ff${base02}, #ff${base04}, #ff${base09}, #ff${base08}, #ff${base02}, #ff${base04}, #ff${base01}, #ff${base00}, #8f${base00}
inactive_colors=#ff${base04}, #ff${base01}, #ff${base01}, #ff${base05}, #ff${base03}, #ff${base04}, #ff${base05}, #ff${base06}, #ff${base05}, #ff${base01}, #ff${base00}, #ff${base03}, #ff${base02}, #ff${base05}, #ff${base09}, #ff${base08}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base05}, #8f${base05}
EOF
fi

mkdir -p "$HOME/.config/qt6ct/colors"
cp -p -f "$new_qt_file" "$HOME/.config/qt6ct/colors/omarchy.conf"

success "Qt6 theme updated!"
exit 0

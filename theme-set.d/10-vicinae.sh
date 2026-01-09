#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/vicinae.toml"

if ! command -v vicinae >/dev/null 2>&1; then
    skipped "Vicinae"
fi

if [ ! -f "$output_file" ]; then
cat > "$output_file" << EOF
[meta]
version = 1
name = "Omarchy"
description = "Follow your Omarchy system theme."
variant = "dark"
inherits = "vicinae-dark"
icon = "$HOME/.local/share/omarchy/icon.png"

[colors.core]
background = "#${primary_background}"
foreground = "#${primary_foreground}"
secondary_background = "#$(change_shade $primary_background 5)"
border = "#${bright_black}"
accent = "#${normal_yellow}"

[colors.list.item.hover]
background = "#$(change_shade $primary_background 10)"
foreground = "#${primary_foreground}"

[colors.list.item.selection]
background = "#$(change_shade $primary_background 15)"
foreground = "#${primary_foreground}"

[colors.accents]
blue = "#${normal_blue}"
green = "#${normal_green}"
magenta = "#${normal_magenta}"
orange = "#${normal_yellow}"
purple = "#${bright_magenta}"
red = "#${normal_red}"
yellow = "#${bright_yellow}"
cyan = "#${normal_cyan}"
EOF
fi

mkdir -p "$HOME/.local/share/vicinae/themes/"
cp -p -f "$output_file" "$HOME/.local/share/vicinae/themes/omarchy.toml"

vicinae theme set omarchy

success "Vicinae theme updated!"
exit 0

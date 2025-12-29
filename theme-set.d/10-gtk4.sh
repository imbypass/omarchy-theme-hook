#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$script_dir/gtk-common"

if [ ! -d "$gtk4_dir" ]; then
    mkdir -p "$gtk4_dir"
fi

if [ -f "$output_file" ]; then
    if [ ! -f "$gtk4_dir/gtk.css.backup" ]; then
        cp "$gtk4_file" "$gtk4_dir/gtk.css.backup"
    fi
    cp -f "$output_file" "$gtk4_file"
else
    create_dynamic_theme
    cp "$output_file" "$gtk4_file"
fi

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-tmp
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3

require_restart "nautilus"
success "GTK theme updated!"
exit 0

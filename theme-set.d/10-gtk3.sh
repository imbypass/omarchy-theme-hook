#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$script_dir/gtk-common"

strip_svg_filter_block() {
    local input_file="$1"
    local output_path="$2"

    awk '
        $0 ~ /^[[:space:]]*\.svg-icon[[:space:]]*\{$/ { in_block=1; next }
        in_block && $0 ~ /^[[:space:]]*\}[[:space:]]*$/ { in_block=0; next }
        !in_block { print }
    ' "$input_file" > "$output_path"
}

if [ ! -d "$gtk3_dir" ]; then
    mkdir -p "$gtk3_dir"
fi

if [ -f "$output_file" ]; then
    if [ ! -f "$gtk3_dir/gtk.css.backup" ]; then
        cp "$gtk3_file" "$gtk3_dir/gtk.css.backup"
    fi
    strip_svg_filter_block "$output_file" "$gtk3_file"
else
    create_dynamic_theme
    strip_svg_filter_block "$output_file" "$gtk3_file"
fi

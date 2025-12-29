#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/vscode_colors.json"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$script_dir/vscode-common"

if ! command -v cursor >/dev/null 2>&1; then
    skipped "Cursor"
fi

if [[ ! -f "$output_file" ]]; then
    write_vscode_colors "$output_file"
fi

extension_name="tintedtheming.base16-tinted-themes"

install_cursor_extension() {
    is_extension_installed=$(cursor --list-extensions | grep "${extension_name}")
    if [[ -z "$is_extension_installed" ]]; then
        cursor --install-extension $extension_name
        sleep 3
    fi
}

cursor_paths=(
    "$HOME/.cursor/extensions/"
)
find_cursor_extension_dir() {
    for path in "${cursor_paths[@]}"; do
        if [[ -d "$path" ]]; then
            install_path=$(find "$path" -maxdepth 1 -type d -name "${extension_name}-*" | head -n1)
        fi
    done
}

modify_extension_manifest() {
    omarchy_entry=$(cat $install_path/package.json | jq 'first(.contributes.themes[] | select(.label == "Omarchy"))')
    if [[ -z "$omarchy_entry" ]]; then
        omarchy_entry='{"label": "Omarchy", "uiTheme": "vs-dark", "path": "./themes/base16/omarchy.json"}'
        new_manifest=$(cat "${install_path}/package.json" | jq --argjson theme "$omarchy_entry" '.contributes.themes += [$theme]')
        echo "$new_manifest" > "${install_path}/package.json"
    fi
}

install_cursor_extension
find_cursor_extension_dir
modify_extension_manifest

install_location="$install_path/themes/base16/omarchy.json"
cp "$output_file" "$install_location"

require_restart "cursor"
success "Cursor theme updated!"
exit 0

#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/vscode_colors.json"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$script_dir/vscode-common"

if ! command -v windsurf >/dev/null 2>&1; then
    skipped "Windsurf"
fi

if [[ ! -f "$output_file" ]]; then
    write_vscode_colors "$output_file"
fi

extension_name="tintedtheming.base16-tinted-themes"

install_extension() {
    is_extension_installed=$(windsurf --list-extensions | grep "${extension_name}")
    if [[ -z "$is_extension_installed" ]]; then
        windsurf --install-extension $extension_name
        sleep 3
    fi
}

install_path=""
vscode_paths=(
    "$HOME/.windsurf/extensions/"
)
find_extension_dir() {
    for path in "${vscode_paths[@]}"; do
        if [[ -d "$path" ]]; then
            install_path=$(find "$path" -maxdepth 1 -type d -name "${extension_name}-*" | head -n1)
        fi
    done
    if [[ -z "$install_path" ]]; then
        exit 1
    fi
}

modify_extension_manifest() {
    omarchy_entry=$(cat $install_path/package.json | jq 'first(.contributes.themes[] | select(.label == "Omarchy"))')
    if [[ -z "$omarchy_entry" ]]; then
        omarchy_entry='{"label": "Omarchy", "uiTheme": "vs-dark", "path": "./themes/base16/omarchy.json"}'
        new_manifest=$(cat "${install_path}/package.json" | jq --argjson theme "$omarchy_entry" '.contributes.themes += [$theme]')
        echo "$new_manifest" > "${install_path}/package.json"
    fi
}

install_extension
find_extension_dir
modify_extension_manifest

install_location="$install_path/themes/base16/omarchy.json"
cp "$output_file" "$install_location"

require_restart "windsurf"
success "Windsurf theme updated!"
exit 0

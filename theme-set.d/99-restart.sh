#!/bin/bash

source "${THEME_HOOK_LIB:-$HOME/.config/omarchy/hooks/theme-set.lib.sh}"

[[ -f "$restart_file" ]] || exit 0

mapfile -t restart_scripts < "$restart_file"
rm -f "$restart_file"

running=()
for app in "${restart_scripts[@]}"; do
    if [[ -n "$app" ]] && pgrep -x "$app" > /dev/null; then
        running+=("${app^}")
    fi
done

[[ ${#running[@]} -gt 0 ]] || exit 0

apps=""
for app in "${running[@]}"; do
    apps+="- $app"$'\n'
done

notify-send "Omarchy Theme Hook" "The following apps require a restart to apply theme:\n\n$apps"

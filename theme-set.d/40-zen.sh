#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/zen.css"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$script_dir/firefox-common"

if ! command -v zen-browser >/dev/null 2>&1; then
    skipped "Zen Browser"
fi

default_profile="$HOME/.zen/$(find_default_profile "$HOME/.zen/profiles.ini")"
enable_userchrome "$default_profile"

mkdir -p "$default_profile/chrome"

write_browser_colors_css "$output_file"
cp "$output_file" "$default_profile/chrome/colors.css"

extra_vars="    --zen-main-browser-background: var(--base00) !important;"
write_user_chrome_css "$default_profile/chrome/userChrome.css" "$extra_vars"
write_user_content_css "$default_profile/chrome/userContent.css" "$extra_vars"

if pgrep -x "zen-browser" > /dev/null; then
    pkill -x "zen-browser" > /dev/null
    sleep 2
    if pgrep -x "zen-browser" > /dev/null; then
        pkill -9 -x "zen-browser" > /dev/null
        sleep 1
    fi
    zen-browser > /dev/null &
fi

require_restart "zen-browser"
success "Zen Browser theme updated!"
exit 0

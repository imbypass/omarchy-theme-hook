#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/firefox.css"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$script_dir/firefox-common"

if ! command -v firefox >/dev/null 2>&1; then
    skipped "Firefox"
fi

default_profile="$HOME/.mozilla/firefox/$(find_default_profile "$HOME/.mozilla/firefox/profiles.ini")"
enable_userchrome "$default_profile"

mkdir -p "$default_profile/chrome"

write_browser_colors_css "$output_file"

if [[ -d "$default_profile" ]]; then
    cp "$output_file" "$default_profile/chrome/colors.css"
fi

write_user_chrome_css "$default_profile/chrome/userChrome.css"
write_user_content_css "$default_profile/chrome/userContent.css"

require_restart "firefox"
success "Firefox theme updated!"
exit 0

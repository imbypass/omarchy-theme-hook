#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/superfile.toml"

if ! command -v spf >/dev/null 2>&1; then
    skipped "Superfile"
fi

if [ ! -f "$output_file" ]; then
cat > "$output_file" << EOF

# ========= Border =========
file_panel_border = '#${normal_white}'
sidebar_border = '#${normal_white}'
footer_border = '#${normal_white}'

# ========= Border Active =========
file_panel_border_active = '#${normal_blue}'
sidebar_border_active = '#${normal_blue}'
footer_border_active = '#${normal_blue}'
modal_border_active = '#${normal_blue}'

# ========= Background (bg) =========
full_screen_bg = '#${primary_background}'
file_panel_bg = '#${primary_background}'
sidebar_bg = '#${primary_background}'
footer_bg = '#${primary_background}'
modal_bg = '#${primary_background}'

# ========= Foreground (fg) =========
full_screen_fg = '#${primary_foreground}'
file_panel_fg = '#${primary_foreground}'
sidebar_fg = '#${primary_foreground}'
footer_fg = '#${primary_foreground}'
modal_fg = '#${primary_foreground}'

# ========= Special Color =========
cursor = '#${primary_foreground}'
correct = '#${normal_green}'
error = '#${normal_red}'
hint = '#${normal_cyan}'
cancel = '#${normal_red}'
gradient_color = ['#${normal_black}', "#${bright_black}"]

# ========= File Panel Special Items =========
file_panel_top_directory_icon = '#${normal_black}'
file_panel_top_path = '#${bright_black}'
file_panel_item_selected_fg = '#${bright_black}'
file_panel_item_selected_bg = '#${primary_background}'

# ========= Sidebar Special Items =========
sidebar_title = '#${bright_white}'
sidebar_item_selected_fg = '#${bright_black}'
sidebar_item_selected_bg = '#${primary_background}'
sidebar_divider = '#${normal_white}'

# ========= Modal Special Items =========
modal_cancel_fg = "#383838"
modal_cancel_bg = '#${normal_red}'
modal_confirm_fg = "#383838"
modal_confirm_bg = '#${normal_green}'
EOF
fi

mkdir -p "$HOME/.config/superfile/theme/"
cp -p -f "$output_file" "$HOME/.config/superfile/theme/omarchy.toml"

require_restart "spf"
success "Superfile theme updated!"
exit 0

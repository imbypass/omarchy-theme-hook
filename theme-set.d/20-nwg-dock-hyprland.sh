#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/nwg-dock.css"
icon_size=22

if ! command -v nwg-dock-hyprland >/dev/null 2>&1; then
    skipped "NWG Dock"
fi

cat > "$output_file" << EOF
window {
    background: #${primary_background}; /* base01 */
    border-color: #${bright_black}; /* base02 */
    border: 2px solid #${bright_black};
}

button,
image {
    color: #${bright_white}; /* base07 */
}

button {
    color: #${normal_white}; /* base05 */
    padding: 3px;
}

button:hover {
    background-color: rgba($rgb_bright_black, 0.5); /* base02 */
}
EOF

mkdir -p "$HOME/.config/nwg-dock-hyprland"
style_file="$HOME/.config/nwg-dock-hyprland/style.css"
if [[ ! -f $style_file ]]; then
cat > $style_file << EOF
@import url("./colors.css");

window {
    border-radius: 12px;
    border-style: solid;
    border-width: 2px;
}

#box {
    padding: 6px;
}

button,
image {
    background: none;
    border-style: none;
    box-shadow: none;
}

button {
    padding: 5px;
    margin-left: 4px;
    margin-right: 4px;
    margin-top: 4px;
    font-size: 18px;
}

button:focus {
    box-shadow: none;
}
EOF
fi

cp "$output_file" "$HOME/.config/nwg-dock-hyprland/colors.css"
killall nwg-dock-hyprland
nwg-dock-hyprland -r -mb 10 -mt 10 -i $icon_size -x -nolauncher & disown

success "Dock theme updated!"

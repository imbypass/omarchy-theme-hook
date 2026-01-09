#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/vencord.theme.css"
possible_paths=(
    "$HOME/.config/Vencord/themes"
    "$HOME/.config/vesktop/themes"
    "$HOME/.config/Equicord/themes"
    "$HOME/.config/equibop/themes"
    "/var/lib/flatpak/app/com.discordapp.Discord/themes"
    "/var/lib/flatpak/app/dev.vencord.Vesktop/themes"
    "/var/lib/flatpak/app/io.github.equicord.equibop/themes",
    "$HOME/.var/app/dev.vencord.Vesktop/config/vesktop/themes"
)

create_dynamic_theme() {

cat > "$output_file" << EOF
    /**
    * @name Omarchy
    * @author @bypass_
    * @version 0.1.0
    * @description Match Omarchy system theme.
    * @source https://github.com/imbypass/base16-Discord
    **/
    @import url("https://imbypass.github.io/base16-discord/omarchy-discord.theme.css");

    :root {
        --color00: #${primary_background};
        --color01: #${primary_background};
        --color02: #${primary_background};
        --color03: #${normal_white};
        --color04: #${bright_white};
        --color05: #${bright_white};
        --color06: #${bright_white};
        --color07: #${bright_white};
        --color08: #${normal_red};
        --color09: #${normal_yellow};
        --color10: #${bright_yellow};
        --color11: #${normal_green};
        --color12: #${normal_cyan};
        --color13: #${normal_blue};
        --color14: #${normal_magenta};
        --color15: #${normal_yellow};
    }
EOF

    for path in "${possible_paths[@]}"; do
        if [ -d "$path" ]; then

            if [[ -f "$path/vencord.theme.css" ]]; then
                rm "$path/vencord.theme.css"
            fi
            cp "$output_file" "$path/vencord.theme.css"

            for file in "$path"/*; do
                if [ -f "$file" ]; then
                    touch "$file"
                fi
            done
        fi
    done
}

check_for_theme() {
    if [[ -f $HOME/.config/omarchy/current/theme/vencord.theme.css ]]; then
        for path in "${possible_paths[@]}"; do
            if [ -d "$path" ]; then
                if [[ -f "$path/vencord.theme.css" ]]; then
                    rm "$path/vencord.theme.css"
                fi
                cp -f $HOME/.config/omarchy/current/theme/vencord.theme.css "$path/vencord.theme.css"
            fi

            for file in "$path"/*; do
                if [ -f "$file" ]; then
                    touch "$file"
                fi
            done
        done
    else
        create_dynamic_theme
    fi
}

check_for_theme
success "Discord theme updated!"
exit 0

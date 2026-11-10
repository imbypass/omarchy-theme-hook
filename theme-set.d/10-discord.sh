#!/bin/bash

source "${THEME_HOOK_LIB:-$HOME/.config/omarchy/hooks/theme-set.lib.sh}"

output_file="$omarchy_theme_dir/vencord.theme.css"
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

cat > "$output_file.tmp" << EOF
    /**
    * @name Match System
    * @author @bypass_
    * @version 0.1.0
    * @description Match your current system theme.
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

    publish_generated_file "$output_file" "$output_file.tmp"

    for path in "${possible_paths[@]}"; do
        if [ -d "$path" ]; then
            cp -f "$output_file" "$path/vencord.theme.css"

            for file in "$path"/*; do
                if [ -f "$file" ]; then
                    touch "$file"
                fi
            done
        fi
    done
}

# Regenerate on every run from colors.toml: the previously generated theme is
# an output, not a source. Keeping the old check_for_theme cache made one bad
# generation (empty colors) stick forever. omarchy-hook may run this hooklette
# a second time without the theme-set wrapper, so generation has to be
# self-contained and idempotent.
create_dynamic_theme
success "Discord theme updated!"
exit 0

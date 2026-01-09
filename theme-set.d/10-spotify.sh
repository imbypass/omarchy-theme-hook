#!/bin/bash

create_spicetify_styling() {
    mkdir -p "$HOME/.config/spicetify/Themes/omarchy"
cat > "$HOME/.config/spicetify/Themes/omarchy/user.css" << EOF
:root,
.encore-dark-theme,
.encore-base-set,
.encore-inverted-light-set {
    --background-highlight: rgba(var(--spice-rgb-highlight), 0.25) !important;
}
.main-nowPlayingBar-container {
    background-color: var(--background-base);
    border-radius: 0.5rem;
    padding: 0.5rem;
    color: var(--spice-text);
}
.main-entityHeader-backgroundColor {
    display: none !important;
}
.main-actionBarBackground-background {
    display: none !important;
}
.main-home-homeHeader {
    display: none !important;
}
.main-topBar-background,
.main-home-filterChipsSection {
    background-color: var(--spice-main) !important;
}
EOF
}

change_spicetify_theme() {
    spicetify config current_theme omarchy > /dev/null
    spicetify config color_scheme base > /dev/null
}

create_dynamic_theme() {
    color00=${primary_background}
    color01=${normal_black}
    color02=${bright_black}
    color03=${normal_white}
    color04=${bright_white}
    color05=${primary_foreground}
    color06=${bright_white}
    color07=${bright_white}
    color08=${normal_red}
    color09=${normal_yellow}
    color0A=${bright_yellow}
    color0B=${normal_green}
    color0C=${normal_cyan}
    color0D=${normal_blue}
    color0E=${normal_magenta}
    color0F=${bright_red}

cat > "$HOME/.config/spicetify/Themes/omarchy/color.ini" << EOF
[base]
main                = ${color00}
player              = ${color00}
card                = ${color00}
main-elevated       = ${color00}
sidebar             = ${color00}
shadow              = ${color00}
notification        = ${color02}
button-disabled     = ${color02}
misc                = ${color03}
selected-row        = ${color03}
button              = ${color03}
highlight           = ${color07}
notification-error  = ${color08}
button-active       = ${color0B}
subtext             = ${color03}
text                = ${color07}
EOF
}

if ! command -v spicetify >/dev/null 2>&1; then
    skipped "Spicetify"
fi

spotify_was_running=false
if pgrep -x "spotify" > /dev/null 2>&1; then
    spotify_was_running=true
fi

create_spicetify_styling
create_dynamic_theme
change_spicetify_theme

if [ "$spotify_was_running" = true ]; then
       spicetify apply > /dev/null 2>&1 &
else
    setsid bash -c '
        spicetify apply > /dev/null 2>&1 &

        for i in {1..250}; do
            if pgrep -x "spotify" > /dev/null 2>&1; then
                sleep 0.2
                killall -9 spotify > /dev/null 2>&1
                exit 0
            fi
            sleep 0.1
        done
    ' > /dev/null 2>&1 < /dev/null &
fi

success "Spotify theme updated!"
exit 0

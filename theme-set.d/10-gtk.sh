#!/bin/bash

source "${THEME_HOOK_LIB:-$HOME/.config/omarchy/hooks/theme-set.lib.sh}"

output_file="$omarchy_theme_dir/gtk.css"
light_file="$omarchy_theme_dir/light.mode"
gtk3_dir="$HOME/.config/gtk-3.0"
gtk4_dir="$HOME/.config/gtk-4.0"
gtk3_file="$gtk3_dir/gtk.css"
gtk4_file="$gtk4_dir/gtk.css"

create_dynamic_theme() {
cat > "$output_file.tmp" << EOF
    @define-color background     #${primary_background};
    @define-color foreground     #${primary_foreground};
    @define-color black          #${primary_background};
    @define-color red            #${normal_red};
    @define-color green          #${normal_green};
    @define-color yellow         #${normal_yellow};
    @define-color blue           #${normal_blue};
    @define-color magenta        #${normal_magenta};
    @define-color cyan           #${normal_cyan};
    @define-color white          #${normal_white};
    @define-color bright_black   #${bright_black};
    @define-color bright_red     #${bright_red};
    @define-color bright_green   #${bright_green};
    @define-color bright_yellow  #${bright_yellow};
    @define-color bright_blue    #${bright_blue};
    @define-color bright_magenta #${bright_magenta};
    @define-color bright_cyan    #${bright_cyan};
    @define-color bright_white   #${bright_white};

    @define-color accent_bg_color @blue;
    @define-color accent_fg_color @background;
    @define-color accent_color @cyan;

    @define-color window_bg_color @background;
    @define-color window_fg_color @foreground;

    @define-color view_bg_color @black;
    @define-color view_fg_color @foreground;
    @define-color sidebar_bg_color @black;
    @define-color sidebar_fg_color @foreground;
    @define-color sidebar_backdrop_color @black;
    @define-color sidebar_shade_color @black;

    @define-color headerbar_bg_color @background;
    @define-color headerbar_fg_color @foreground;
    @define-color headerbar_backdrop_color @black;
    @define-color headerbar_shade_color @black;
    @define-color card_bg_color @background;
    @define-color card_fg_color @foreground;

    @define-color popover_bg_color @black;
    @define-color popover_fg_color @foreground;

    @define-color destructive_bg_color @red;
    @define-color destructive_fg_color @background;

    @define-color success_bg_color @green;
    @define-color success_fg_color @background;

    @define-color warning_bg_color @yellow;
    @define-color warning_fg_color @background;

    @define-color error_bg_color @red;
    @define-color error_fg_color @background;

    @define-color dialog_bg_color @background;
    @define-color dialog_fg_color @foreground;

    @define-color borders alpha(@foreground, 0.1);

    @define-color theme_fg_color @foreground;
    @define-color theme_text_color @foreground;
    @define-color theme_bg_color @background;
    @define-color theme_base_color @black;
    @define-color theme_selected_bg_color @blue;
    @define-color theme_selected_fg_color @background;
    @define-color insensitive_bg_color @background;
    @define-color insensitive_fg_color @bright_black;
    @define-color insensitive_base_color @black;
    @define-color theme_unfocused_fg_color @foreground;
    @define-color theme_unfocused_text_color @foreground;
    @define-color theme_unfocused_bg_color @background;
    @define-color theme_unfocused_base_color @black;
    @define-color theme_unfocused_selected_bg_color @blue;
    @define-color theme_unfocused_selected_fg_color @background;
    @define-color unfocused_insensitive_color @bright_black;
    @define-color unfocused_borders alpha(@foreground, 0.1);
    @define-color warning_color @yellow;
    @define-color error_color @red;
    @define-color success_color @green;
    @define-color destructive_color @red;

    @define-color content_view_bg @black;
    @define-color text_view_bg @black;

    messagedialog {
        background-color: @dialog_bg_color;
    }

    messagedialog label {
        color: @dialog_fg_color;
        font-size: 14pt;
        font-weight: bold;
    }

    messagedialog .secondary-text {
        font-size: 10pt;
        font-style: italic;
    }

    messagedialog button {
        background-color: @black;
        color: @foreground;
        border: 1px solid @bright_black;
        padding: 10px;
    }

    messagedialog button:hover {
        background-color: @blue;
    }

    banner revealer widget {
        background: @bright_black;
        padding: 5px;
        color: @foreground;
    }

    alertdialog.background {
        background-color: @dialog_bg_color;
        color: @dialog_fg_color;
    }

    alertdialog .titlebar {
        background-color: @headerbar_bg_color;
        color: @headerbar_fg_color;
    }

    alertdialog box {
        background-color: @dialog_bg_color;
    }

    alertdialog label {
        color: @dialog_fg_color;
    }

    filechooser .dialog-action-box {
        border-top: 1px solid @bright_black;
    }

    filechooser .dialog-action-box:backdrop {
        border-top-color: @black;
    }

    filechooser #pathbarbox {
        border-bottom: 1px solid @bright_black;
    }

    filechooserbutton:drop(active) {
        box-shadow: none;
        border-color: transparent;
    }

    toast {
        background-color: @black;
        color: @foreground;
    }

    toast button.circular.flat.image-button:hover {
        color: @background;
        background-color: @red;
    }

    /* .svg-icon {
        filter: invert(79%) sepia(18%) saturate(611%) hue-rotate(192deg)
            brightness(103%) contrast(94%);
    } */
EOF
}

if [ ! -d "$gtk3_dir" ]; then
    mkdir -p "$gtk3_dir"
fi
if [ ! -d "$gtk4_dir" ]; then
    mkdir -p "$gtk4_dir"
fi

# Preserve the pre-hook CSS once, before the first generation overwrites it.
# This must happen on every run until a backup exists: the previously
# generated file is never a source, so backing it up does not restore it.
if [ ! -f "$gtk3_dir/gtk.css.backup" ] && [ -f "$gtk3_file" ]; then
    cp "$gtk3_file" "$gtk3_dir/gtk.css.backup"
fi
if [ ! -f "$gtk4_dir/gtk.css.backup" ] && [ -f "$gtk4_file" ]; then
    cp "$gtk4_file" "$gtk4_dir/gtk.css.backup"
fi

# Regenerate on every run from colors.toml: the previously generated gtk.css
# is an output, not a source. omarchy-hook may run this hooklette a second
# time without the theme-set wrapper, so generation has to be self-contained
# and idempotent. The colors were validated by the library, and
# publish_generated_file refuses to publish anything malformed, so the GTK
# files can never end up with empty `#;` colors (which render windows
# transparent on libadwaita).
create_dynamic_theme
publish_generated_file "$output_file" "$output_file.tmp"
cp -f "$output_file" "$gtk3_file"
cp -f "$output_file" "$gtk4_file"

# Omarchy 4.5 derives light/dark from colors.toml (`mode = "light"`) through
# omarchy-theme-color; the legacy light.mode marker file still wins if present.
if [ -f "$light_file" ]; then
    mode="light"
elif command -v omarchy-theme-color >/dev/null 2>&1; then
    mode=$(omarchy-theme-color --file "$colors_file" mode)
else
    mode="dark"
fi

if [ "$mode" = "light" ]; then
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-tmp
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3
else
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-tmp-dark
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
fi

pkill -f xdg-desktop-portal-gtk

require_restart "nautilus"
success "GTK theme updated!"
exit 0

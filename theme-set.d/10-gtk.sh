#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/gtk.css"
gtk3_dir="$HOME/.config/gtk-3.0"
gtk4_dir="$HOME/.config/gtk-4.0"
gtk3_file="$gtk3_dir/gtk.css"
gtk4_file="$gtk4_dir/gtk.css"

create_dynamic_theme() {
cat > "$output_file" << EOF
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

if [ -f "$output_file" ]; then
    if [ ! -f "$gtk3_dir/gtk.css.backup" ]; then
        cp "$gtk3_file" "$gtk3_dir/gtk.css.backup"
    fi
    cp -f "$output_file" "$gtk3_file"

    if [ ! -f "$gtk4_dir/gtk.css.backup" ]; then
        cp "$gtk4_file" "$gtk4_dir/gtk.css.backup"
    fi
    cp -f "$output_file" "$gtk4_file"
else
    create_dynamic_theme
    cp "$output_file" "$gtk3_file"
    cp "$output_file" "$gtk4_file"
fi

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-tmp
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3
pkill -f xdg-desktop-portal-gtk

require_restart "nautilus"
success "GTK theme updated!"
exit 0

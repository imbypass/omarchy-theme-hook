#!/bin/bash

new_zed_file="$HOME/.config/omarchy/current/theme/zed.json"

create_dynamic_theme() {
cat > "$new_zed_file" << EOF
    {
      "\$schema": "https://zed.dev/schema/themes/v0.1.0.json",
      "name": "Omarchyy",
      "author": "@bypass_",
      "themes": [
        {
          "name": "Omarchy",
          "appearance": "dark",
          "style": {
            "background": "#${primary_background}90",
            "editor.background": "#${primary_background}90",
            "editor.foreground": "#${primary_foreground}",
            "text": "#${primary_foreground}",
            "text.muted": "#${primary_foreground}70",
            "text.ignored": "#${primary_foreground}40",
            "text.placeholder": "#${primary_foreground}50",
            "ignored": "#${primary_foreground}30",
            "element.hover": "#${primary_foreground}30",
            "ghost_element.hover": "#${bright_black}30",
            "ghost_element.selected": "#${bright_black}30",
            "ghost_element.active": "#${bright_black}60",
            "border": "#${normal_black}",
            "editor.highlighted_line.background": "#${bright_black}10",
            "editor.active_line.background": "#${bright_black}10",
            "panel.background": "#${normal_black}90",
            "title_bar.background": "#${normal_black}90",
            "title_bar.inactive_background": "#${normal_black}90",
            "status_bar.background": "#${normal_black}90",
            "drop_target.background": "#${normal_black}90",
            "elevated_surface.background": "#${normal_black}",
            "toolbar.background": "#${normal_black}90",
            "tab_bar.background": "#${normal_black}90",
            "tab.inactive_background": "#${normal_black}90",
            "tab.active_background": "#${bright_black}30",
            "scrollbar.track.background": "transparent",
            "scrollbar.track.border": "#${normal_black}",
            "scrollbar.thumb.background": "#${primary_foreground}",
            "editor.gutter.background": "#${normal_black}90",
            "terminal.background": "#${normal_black}10",
            "terminal.foreground": "#${primary_foreground}",
            "terminal.dim_foreground": "#${primary_foreground}",
            "terminal.bright_foreground": "#${primary_foreground}",
            "terminal.ansi.black": "#${normal_black}",
            "terminal.ansi.red": "#${normal_red}",
            "terminal.ansi.green": "#${normal_green}",
            "terminal.ansi.yellow": "#${normal_yellow}",
            "terminal.ansi.blue": "#${normal_blue}",
            "terminal.ansi.magenta": "#${normal_magenta}",
            "terminal.ansi.cyan": "#${normal_cyan}",
            "terminal.ansi.white": "#${normal_white}",
            "terminal.ansi.bright_black": "#${bright_black}",
            "terminal.ansi.bright_red": "#${bright_red}",
            "terminal.ansi.bright_green": "#${bright_green}",
            "terminal.ansi.bright_yellow": "#${bright_yellow}",
            "terminal.ansi.bright_blue": "#${bright_blue}",
            "terminal.ansi.bright_magenta": "#${bright_magenta}",
            "terminal.ansi.bright_cyan": "#${bright_cyan}",
            "terminal.ansi.bright_white": "#${bright_white}",
            "modified": "#${normal_red}",
            "syntax": {
              "attribute": {
                "color": "#${normal_white}"
              },
              "boolean": {
                "color": "#${normal_green}"
              },
              "comment": {
                "color": "#${bright_black}"
              },
              "comment.doc": {
                "color": "#${bright_black}"
              },
              "constant": {
                "color": "#${bright_green}"
              },
              "function": {
                "color": "#${bright_cyan}"
              },
              "keyword": {
                "color": "#${normal_blue}"
              },
              "number": {
                "color": "#${normal_magenta}"
              },
              "operator": {
                "color": "#${normal_blue}"
              },
              "string": {
                "color": "#${normal_red}"
              },
              "variable": {
                "color": "#${normal_green}"
              }
            },
            "players": [
              {
                "cursor": "#${primary_foreground}",
                "background": "#${normal_black}",
                "selection": "#${primary_foreground}30"
              }
            ]
          }
        }
      ]
    }
EOF
}

if ! command -v zeditor >/dev/null 2>&1; then
    skipped "Zed"
fi

mkdir -p "$HOME/.config/zed/themes"
if [ -f "$new_zed_file" ]; then
    cp -f "$new_zed_file" "$HOME/.config/zed/themes/omarchy.json"
else
    create_dynamic_theme
    cp -f "$new_zed_file" "$HOME/.config/zed/themes/omarchy.json"
fi

success "Zed theme updated!"
exit 0

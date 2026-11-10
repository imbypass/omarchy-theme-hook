#!/bin/bash

source "${THEME_HOOK_LIB:-$HOME/.config/omarchy/hooks/theme-set.lib.sh}"

# Typora theme hook - generates CSS with current omarchy theme colors

new_typora_file="$omarchy_theme_dir/typora.css"
typora_dir="$HOME/.config/Typora/themes"

create_dynamic_theme() {
    # Calculate darker shade for sidebar
    sidebar_bg=$(change_shade "$primary_background" -15)
    # Calculate selection color
    select_bg=$(change_shade "$normal_blue" -60)
    # Calculate hover/active colors
    hover_bg=$(change_shade "$primary_background" 20)

    cat > "$new_typora_file" << EOF
@import "night/mermaid.dark.css";
@import "night/codeblock.dark.css";
@import "night/sourcemode.dark.css";

:root {
    --bg-color: #${primary_background};
    --side-bar-bg-color: #${sidebar_bg};
    --text-color: #${primary_foreground};

    --select-text-bg-color: #${select_bg};

    --item-hover-bg-color: #${hover_bg};
    --control-text-color: #${bright_black};
    --control-text-hover-color: #${primary_foreground};
    --window-border: 1px solid #${hover_bg};

    --active-file-bg-color: #${hover_bg};
    --active-file-border-color: #${normal_blue};

    --primary-color: #${normal_blue};

    --active-file-text-color: #${primary_foreground};
    --item-hover-text-color: #${primary_foreground};

    --rawblock-edit-panel-bd: #${sidebar_bg};

    --search-select-bg-color: #${select_bg};
}

html {
    font-size: 16px;
    -webkit-font-smoothing: antialiased;
}

html,
body {
    -webkit-text-size-adjust: 100%;
    -ms-text-size-adjust: 100%;
    background: #${primary_background};
    background: var(--bg-color);
    fill: currentColor;
    line-height: 1.625rem;
}

#write {
    max-width: 914px;
}

@media only screen and (min-width: 1400px) {
    #write {
        max-width: 1024px;
    }
}

@media only screen and (min-width: 1800px) {
    #write {
        max-width: 1200px;
    }
}

html,
body,
button,
input,
select,
textarea,
div.code-tooltip-content {
    color: #${primary_foreground};
    border-color: transparent;
}

div.code-tooltip,
.md-hover-tip .md-arrow:after {
    background: #${sidebar_bg};
}

.native-window #md-notification {
    border: 1px solid #${bright_black};
}

.popover.bottom > .arrow:after {
    border-bottom-color: #${sidebar_bg};
}

html,
body,
button,
input,
select,
textarea {
    font-family: "Inter", "SF Pro", -apple-system, BlinkMacSystemFont, sans-serif;
}

hr {
    height: 2px;
    border: 0;
    margin: 24px 0 !important;
}

/* Headers */
h1, h2, h3, h4, h5, h6 {
    font-family: "SF Pro", "Inter", -apple-system, BlinkMacSystemFont, sans-serif;
    color: #${primary_foreground};
}

/* Links */
a {
    color: #${normal_blue};
}

/* Code */
code, pre, .md-fences {
    font-family: "JetBrainsMono Nerd Font", "Fira Code", monospace;
    background: #${sidebar_bg};
}

/* Inline code */
code {
    color: #${normal_cyan};
    padding: 2px 4px;
    border-radius: 4px;
}

/* Blockquotes */
blockquote {
    border-left: 4px solid #${normal_blue};
    color: #${bright_black};
}

/* Tables */
table tr:nth-child(2n) {
    background: #${sidebar_bg};
}

table th {
    background: #${hover_bg};
}

/* Scrollbars */
::-webkit-scrollbar-thumb {
    background: #${hover_bg};
}

::-webkit-scrollbar-thumb:hover {
    background: #${bright_black};
}
EOF
}

# Check if Typora is installed
if ! command -v typora >/dev/null 2>&1; then
    skipped "Typora"
fi

mkdir -p "$typora_dir"

if [ -f "$new_typora_file" ]; then
    cp -f "$new_typora_file" "$typora_dir/omarchy.css"
else
    create_dynamic_theme
    cp -f "$new_typora_file" "$typora_dir/omarchy.css"
fi

success "Typora theme updated!"
require_restart "typora"
exit 0

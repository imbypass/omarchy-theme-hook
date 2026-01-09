#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/fzf.fish"

if ! command -v fish >/dev/null 2>&1; then
    skipped "Fish - FZF"
fi

cat > "$output_file" << EOF
set -l color00 '#${normal_black}'
set -l color01 '#${normal_red}'
set -l color02 '#${normal_green}'
set -l color03 '#${normal_yellow}'
set -l color04 '#${normal_blue}'
set -l color05 '#${normal_magenta}'
set -l color06 '#${normal_cyan}'
set -l color07 '#${normal_white}'
set -l color08 '#${bright_black}'
set -l color09 '#${bright_red}'
set -l color0A '#${bright_green}'
set -l color0B '#${bright_yellow}'
set -l color0C '#${bright_blue}'
set -l color0D '#${bright_magenta}'
set -l color0E '#${bright_cyan}'
set -l color0F '#${bright_white}'

set -l FZF_NON_COLOR_OPTS

for arg in (echo \$FZF_DEFAULT_OPTS | tr " " "\n")
    if not string match -q -- "--color*" \$arg
        set -a FZF_NON_COLOR_OPTS \$arg
    end
end

set -Ux FZF_DEFAULT_OPTS "\$FZF_NON_COLOR_OPTS"\
" --color=bg+:\$color00,bg:\$color00,spinner:\$color0E,hl:\$color0D"\
" --color=fg:\$color07,header:\$color0D,info:\$color0A,pointer:\$color0E"\
" --color=marker:\$color0E,fg+:\$color06,prompt:\$color0A,hl+:\$color0D"
EOF

fish source "$output_file"
success "fzf colors updated!"

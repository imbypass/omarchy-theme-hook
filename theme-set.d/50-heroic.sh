#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/heroic.css"

if ! command -v heroic >/dev/null 2>&1; then
    skipped "Heroic Launcher"
fi

if [[ ! -f "$output_file" ]]; then
cat > "$output_file" << EOF
body.heroic {
  --background: #${primary_background};
  --background-darker: #$(change_shade $primary_background -5);
  --background-secondary: #$(change_shade $primary_background 5);
  --background-lighter: #$(change_shade $primary_background 10);
  --accent: #${normal_blue};
  --text-default: #${primary_foreground};
  --navbar-accent: #${normal_blue};
  --navbar-active-background: #${bright_black};
  --success: #${normal_green};
  --success-hover: #${bright_green};
  --primary: #${normal_blue};
  --primary-hover: #${bright_blue};
  --danger: #${normal_red};
  --danger-hover: #${bright_red};
  --anticheat-supported: #${normal_green};
  --anticheat-planned: #${normal_cyan};
  --icon-disabled: #${bright_red};
  --cancel-button: #${normal_red};
  --anticheat-broken: #${normal_red};

  --accent-overlay: var(--accent);
  --navbar-background: var(--background);
  --body-background: var(--background-darker);
  --current-background: var(--body-background);
  --text-secondary: var(--text-default);
  --text-tertiary: var(--background);
  --navbar-active: var(--accent);
  --input-background: var(--background);
  --modal-background: var(--body-background);
  --modal-border: var(--body-background);
  --anticheat-denied: var(--danger);
  --anticheat-running: var(--text-default);
  --text-title: var(--text-default);
  --icons-background: var(--background-lighter);
  --action-icon: var(--navbar-accent);
  --action-icon-hover: var(--text-default);
  --action-icon-active: var(--accent);
  --neutral-06: var(--text-default);
}
EOF
fi

require_restart "heroic"
success "Heroic theme updated!"
exit 0

#!/bin/bash

# This script respects user's existing nwg-dock-hyprland configuration.
# It searches ~/.config/hypr/*.conf for exec/exec-once commands and preserves user flags.
# Falls back to default configuration only if no user command is found.

output_file="$HOME/.config/omarchy/current/theme/nwg-dock.css"
default_dock_command="nwg-dock-hyprland -r -mb 10 -mt 10 -i 22 -x -nolauncher"

if ! command -v nwg-dock-hyprland >/dev/null 2>&1; then
  skipped "NWG Dock"
fi

# Search for user's nwg-dock-hyprland command in Hyprland config files
user_dock_command=""
hypr_config_dir="$HOME/.config/hypr"

if [[ -d "$hypr_config_dir" ]]; then
  # Find all config files containing nwg-dock-hyprland exec commands
  mapfile -t dock_files < <(grep -l -E "^\s*(exec|exec-once)\s*=.*nwg-dock-hyprland" "$hypr_config_dir"/*.conf 2>/dev/null)

  # Find all matching command lines
  mapfile -t dock_commands < <(grep -h -E "^\s*(exec|exec-once)\s*=.*nwg-dock-hyprland" "$hypr_config_dir"/*.conf 2>/dev/null)

  # Check for multiple commands and warn user
  if [[ ${#dock_commands[@]} -gt 1 ]]; then
    warning "Multiple nwg-dock-hyprland commands found in Hyprland config:"
    for file in "${dock_files[@]}"; do
      warning "  - $file"
    done
    warning "Using first occurrence. Please consolidate to a single command."
  fi

  # Extract the command from first match
  if [[ ${#dock_commands[@]} -gt 0 ]]; then
    # Remove 'exec' or 'exec-once' prefix and '=' sign, trim whitespace
    user_dock_command=$(echo "${dock_commands[0]}" | sed 's/^[[:space:]]*exec\(-once\)\?[[:space:]]*=[[:space:]]*//')

    # Validate extraction succeeded
    if [[ -z "$user_dock_command" || ! "$user_dock_command" =~ nwg-dock-hyprland ]]; then
      warning "Failed to parse user's nwg-dock-hyprland command: ${dock_commands[0]}"
      warning "Using default configuration."
      user_dock_command=""
    fi
  fi
fi

if [[ ! -f "$output_file" ]]; then
  cat >"$output_file" <<EOF
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
fi

mkdir -p "$HOME/.config/nwg-dock-hyprland"
style_file="$HOME/.config/nwg-dock-hyprland/style.css"
if [[ ! -f $style_file ]]; then
  cat >$style_file <<EOF
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

# Kill existing dock instance
killall nwg-dock-hyprland 2>/dev/null

# Restart dock with user's command or default
if [[ -n "$user_dock_command" ]]; then
  eval "$user_dock_command" &
  disown
else
  eval "$default_dock_command" &
  disown
fi

success "Dock theme updated!"

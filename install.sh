#! /bin/bash

set -e

# Install prerequisites
if ! pacman -Qi "adw-gtk-theme" &>/dev/null; then
    gum style --border normal --border-foreground 6 --padding "1 2" \
    "\"adw-gtk-theme\" is required to theme GTK applications."

    if gum confirm "Would you like to install \"adw-gtk-theme\"?"; then
        sudo pacman -S adw-gtk-theme
    fi
fi

# Remove any old temp files
rm -rf /tmp/theme-hook/

# Clone the Omarchy theme hook repository
echo -e "Downloading theme hook.."
git clone https://github.com/imbypass/omarchy-theme-hook.git /tmp/theme-hook > /dev/null 2>&1

# Remove any old update alias
rm -rf $HOME/.local/share/omarchy/bin/theme-hook-update > /dev/null 2>&1

# Remove thctl from the Omarchy tree, which is moved aside by the Omarchy 4 upgrade
rm -rf $HOME/.local/share/omarchy/bin/thctl > /dev/null 2>&1

# Create a theme control alias
mkdir -p $HOME/.local/bin
mv -f /tmp/theme-hook/thctl $HOME/.local/bin/thctl
chmod +x $HOME/.local/bin/thctl

# Copy the theme-set hook and its shared library to the Omarchy hooks directory
mkdir -p $HOME/.config/omarchy/hooks/
mv -f /tmp/theme-hook/theme-set $HOME/.config/omarchy/hooks/
mv -f /tmp/theme-hook/theme-set.lib.sh $HOME/.config/omarchy/hooks/

# Create theme hook directory and copy scripts
mkdir -p $HOME/.config/omarchy/hooks/theme-set.d/
mv -f /tmp/theme-hook/theme-set.d/* $HOME/.config/omarchy/hooks/theme-set.d/

# Remove any new temp files
rm -rf /tmp/theme-hook

# Update permissions
chmod +x $HOME/.config/omarchy/hooks/theme-set
chmod +x $HOME/.config/omarchy/hooks/theme-set.d/*

# Update Omarchy theme
echo "Running theme hook.."
omarchy-hook theme-set

omarchy-show-done

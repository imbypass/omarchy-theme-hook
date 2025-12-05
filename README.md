
<div align="center">

![Preview](assets/preview.png)

# Omarchy Theme Hook
   
[![Themed Apps](https://img.shields.io/badge/themed_apps-23-blue?style=for-the-badge&labelColor=0C0D11&color=A5CAB8)](https://github.com/imbypass/omarchy-theme-hook/tree/main/theme-set.d)
[![GitHub Issues](https://img.shields.io/github/issues/imbypass/omarchy-theme-hook?style=for-the-badge&labelColor=0C0D11&color=EB7A73)](https://github.com/imbypass/omarchy-theme-hook/issues)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/imbypass/omarchy-theme-hook?style=for-the-badge&labelColor=0C0D11&color=8ECD84)](https://github.com/imbypass/omarchy-theme-hook/commits/main/)
[![GitHub Stars](https://img.shields.io/github/stars/imbypass/omarchy-theme-hook?style=for-the-badge&labelColor=0C0D11&color=EFBE71)](https://github.com/imbypass/omarchy-theme-hook/stargazers)

**A lightweight, clean solution to extending your Omarchy theme to other apps.**

</div>

## Overview
The Omarchy Theme Hook is a lightweight, clean solution to extending your Omarchy theme to other apps. It will check your Omarchy theme for the existence of any extended theme files and will install them automatically for you when a theme is applied. If a theme is applied that contains extended theme files, they will be copied to their proper folders. If the theme does *not* contain any extended theme files, a new set of each will be generated dynamically using the theme's Alacritty config and copied to their proper folders.

## Installing
You can install the theme hook by running the following command:
```
curl -fsSL https://imbypass.github.io/omarchy-theme-hook/install.sh | bash
```

## Updating
You can update the theme hook by running the following command:
```
theme-hook-update
```

## Themed Apps
- Alacritty
- Cava
- Chromium
- Cursor
- Discord
- Firefox
- Ghostty
- GTK (requires `adw-gtk-theme` from the AUR)
- Hyprland
- Kitty
- Mako
- Nwg-dock-hyprland
- QT6
- Spotify
- Steam
- Superfile
- SwayOSD
- Vicinae
- VS Code
- Walker
- Waybar
- Windsurf
- Zed
- Zen Browser (experimental - requires manual enabling of legacy userchrome styling)

## FAQ

#### I installed the hook, but none of my apps are theming!
1. The theme hook will generate and install themes, but cannot apply all of them.
2. You may need to manually set the theme to "Omarchy" one time for each app that supports theming.

#### My Firefox/Zen Browser isn't theming!
-  Firefox and Zen Browser may require manual enabling of legacy userchrome styling.
-  To do this, open the browser, go to `about:config`, search for `toolkit.legacyUserProfileCustomizations.stylesheets`, and set it to `true`.

#### My Discord isn't theming!
1. Make sure you are using a third-party Discord client, like Vesktop or Equibop.
2. Apply your desired theme in Omarchy.
3. Enable the Omarchy theme in Discord.

#### My Spotify isn't theming!
1. Make sure that you *properly* installed Spicetify, including any permission edits that may need to be made for Linux systems.
2. See a [[note for Linux users]](https://spicetify.app/docs/advanced-usage/installation#note-for-linux-users).
3. Apply your desired theme in Omarchy.

#### What if I encounter issues?
If you encounter any issues, please open an issue on the GitHub repository.

#### Will you share your waybar configuration?
It's on GitHub.
https://github.com/imbypass/omarchy-waybar-bepi

## Contributing
I actively encourage everyone to contribute a theme for their favorite application. If you have a theme for an application, an upgrade to an existing script, or even just feature ideas, please open a pull or a feature request on the GitHub repository. I try my best to review and merge them quickly. As a general rule of thumb, try to keep any templates submitted limited to a single script file.

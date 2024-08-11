#!/usr/bin/env bash
set -euo pipefail

# Randomly choose cursor theme
XCURSOR_THEME="$(basename "$(find "$HOME/.icons"/* -prune -print | shuf --head-count 1)")"

if [ -n "$XCURSOR_THEME" ]; then
	# Apply theme to Hyprland
	hyprctl setcursor "$XCURSOR_THEME" 24
	# Apply to theme to GTK
	gsettings set org.gnome.desktop.interface cursor-theme "$XCURSOR_THEME"
fi

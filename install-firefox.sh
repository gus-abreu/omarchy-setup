#!/bin/sh
set -e

yay -S --noconfirm --needed firefox
xdg-settings set default-web-browser firefox.desktop

# Check if installed and remove
pacman -Q omarchy-chromium &>/dev/null && yay -Rns --noconfirm omarchy-chromium

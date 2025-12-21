#!/bin/sh
set -e

yay -S --noconfirm --needed firefox
xdg-settings set default-web-browser firefox.desktop
yay -Rns --noconfirm omarchy-chromium || true

#!/bin/bash
set -e

REPO_URL="https://github.com/gus-abreu/dotfiles"
REPO_NAME="dotfiles"

# Verify stow is installed
pacman -Qi stow &> /dev/null || { echo "Install stow first"; exit 1; }

cd ~

# Clone if needed
if [ ! -d "$REPO_NAME" ]; then
  git clone "$REPO_URL"
fi

# Backup and stow configs
[ -d ~/.config/hypr ] && mv ~/.config/hypr ~/.config/hypr.bak
cd "$REPO_NAME"
stow hypr
hyprctl reload
sudo stow -t / firefox

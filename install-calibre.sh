#!/bin/bash
set -euo pipefail

# Install Calibre using the official upstream installer
# https://calibre-ebook.com/download_linux
# Bundles its own dependencies; upgrade later with `sudo calibre --update`.
echo "Installing Calibre (official installer)..."
sudo -v
curl -fsSL https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

echo "Calibre installed! Run 'sudo calibre-uninstall' to remove, or 'calibre' to launch."

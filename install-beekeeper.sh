#!/bin/bash
set -e

# Install Beekeeper Studio (database manager)
echo "Installing Beekeeper Studio..."
yay -S --noconfirm --needed beekeeper-studio-bin

echo "Beekeeper Studio installed!"

#!/bin/sh
set -e
echo "Installing audio tools..."
yay -S --noconfirm --needed pavucontrol alsa-utils
echo "Done. Run 'pavucontrol' to adjust mic levels."

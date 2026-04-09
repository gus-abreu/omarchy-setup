#!/bin/bash
set -e

echo "Installing QGIS..."
yay -S --noconfirm --needed qgis qt6-tools arrow

echo ""
echo "QGIS installed."
echo "Done!"

#!/bin/sh
set -e
echo "Installing Lenovo ELAN fingerprint driver (04f3:0c4b)..."

# Dependencies: openssl-1.1 for proprietary driver, libfprint-tod for TOD support
yay -S --noconfirm --needed openssl-1.1 libfprint-tod

# Lenovo's proprietary ELAN driver from AUR
yay -S --noconfirm --needed libfprint-2-tod1-elan

# Restart fprintd to load the new driver
sudo systemctl restart fprintd.service

echo "Fingerprint driver installed. Run 'omarchy-setup-fingerprint' to enroll fingerprints."

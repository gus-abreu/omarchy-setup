#!/bin/sh
set -e

# AMD CPU microcode + GPU drivers
yay -S --noconfirm --needed amd-ucode vulkan-radeon vulkan-tools

# Regenerate initramfs for microcode
sudo mkinitcpio -P

# Verify Vulkan works
echo "Verifying Vulkan..."
vulkaninfo --summary > /dev/null || { echo "ERROR: Vulkan not working!"; exit 1; }
echo "✓ AMD CPU + GPU ready"
vulkaninfo --summary | grep deviceName

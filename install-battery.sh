#!/bin/sh
set -e
echo "Installing TLP for battery optimization..."
yay -S --noconfirm --needed tlp tlp-rdw

sudo systemctl enable tlp.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
sudo systemctl mask power-profiles-daemon.service

# Configure TLP for aggressive battery savings
sudo tee /etc/tlp.d/01-battery.conf > /dev/null << 'EOF'
# Platform profile: low-power on battery
PLATFORM_PROFILE_ON_BAT=low-power

# CPU energy preference: maximum power saving on battery
CPU_ENERGY_PERF_POLICY_ON_BAT=power

# Disable CPU boost on battery (significant power savings)
CPU_BOOST_ON_BAT=0
CPU_HWP_DYN_BOOST_ON_BAT=0

# WiFi power saving
WIFI_PWR_ON_BAT=on

# PCIe aggressive power management
PCIE_ASPM_ON_BAT=powersupersave
EOF

sudo tlp start

# Lenovo conservation mode (limit charge to ~60% for battery longevity)
echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
echo "TLP installed and configured. Expected idle power: 6-9W."

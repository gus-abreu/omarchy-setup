# omarchy-setup

## [Download ISO](https://omarchy.org/)

## Create bootable USB

```sh
sudo dd bs=4M if=omarchy-3.2.3-2.iso of=/dev/sda status=progress oflag=sync
```

## [Welcome to Omarchy](https://learn.omacom.io/2/the-omarchy-manual/91/welcome-to-omarchy)

`cd && git clone https://github.com/gus-abreu/omarchy-setup.git`

`cd omarchy-setup`

`./setup.sh`

`gh auth login`

`gh auth setup-git`

https://www.youtube.com/watch?v=d23jFJmcaMI

## Useful Commands

```sh
# Firmware updates
omarchy-update-firmware

# Battery conservation (Lenovo - limits to 60%)
echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

# Temps
sensors

# Mic adjustment
pavucontrol  # Input Devices > Internal Microphone > ~80-100%
```

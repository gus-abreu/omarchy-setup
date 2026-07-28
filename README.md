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


## Audio (AirPods / Bluetooth headset mic)

Symptom: on calls the AirPod mic gives robotic/garbled audio (dmesg shows
`SCO packet for unknown connection handle`). Cause: the MediaTek Bluetooth
chip (`btmtk`) can't handle the **LC3 HFP codec** PipeWire auto-picks. Only
mSBC/CVSD work.

Fix — disable LC3 so WirePlumber falls back to mSBC (and auto-switches to
headset mode on calls, back to A2DP hi-fi for music):

`~/.config/wireplumber/wireplumber.conf.d/51-bluetooth-airpods-hfp.conf`
```
monitor.bluez.properties = {
  bluez5.codecs = [ aac sbc_xq sbc msbc cvsd ]   # note: no lc3_swb / lc3_a127
  bluez5.enable-msbc = true
  bluez5.enable-sbc-xq = true
}
```
Then `systemctl --user restart wireplumber pipewire pipewire-pulse`, and once
select the mSBC headset profile so it's remembered (pavucontrol > Configuration,
or `pactl set-card-profile <bluez_card...> headset-head-unit`).

Note: AirPods can't do hi-fi output + mic at the same time (Bluetooth A2DP vs
HFP) — call output is mono by design. In Google Meet, set mic AND speaker to the
AirPods (it remembers per browser). Test tools: `pavucontrol`, `omarchy launch audio`.

run omarchy-setup-fingerprint manually to enroll fingerprints

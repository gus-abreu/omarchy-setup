#!/bin/bash

# Exit on any error
set -e

# Install AMD drivers and verify before continuing
./install-amd.sh

./install-stow.sh
./install-firefox.sh
./install-zed.sh
./install-claude.sh
#./install-thunderbird.sh
./install-uv.sh
./install-audio.sh
./install-fingerprint.sh

./install-dotfiles.sh

source ~/.bashrc

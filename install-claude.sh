#!/bin/sh
set -e

curl -fsSL https://claude.ai/install.sh | bash

# Add to PATH if not already there
touch ~/.bashrc
grep -q '.local/bin' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc


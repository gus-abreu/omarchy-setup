#!/bin/bash
set -e

DOWNLOAD_URL="https://www.ticktick.com/static/getApp/download?type=linux_appimage_x64"
APPIMAGE_PATH="$HOME/Applications/ticktick.AppImage"
ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
DESKTOP_DIR="$HOME/.local/share/applications"

# Create directories
mkdir -p "$HOME/Applications"
mkdir -p "$ICON_DIR"
mkdir -p "$DESKTOP_DIR"

# Download AppImage
echo "Downloading TickTick AppImage..."
curl -L -o "$APPIMAGE_PATH" "$DOWNLOAD_URL"
chmod +x "$APPIMAGE_PATH"

# Extract icon from AppImage
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
"$APPIMAGE_PATH" --appimage-extract usr/share/icons/hicolor/256x256/apps/ticktick.png >/dev/null 2>&1
cp squashfs-root/usr/share/icons/hicolor/256x256/apps/ticktick.png "$ICON_DIR/"
cd - >/dev/null
rm -rf "$TEMP_DIR"

# Create desktop entry
cat > "$DESKTOP_DIR/ticktick.desktop" << EOF
[Desktop Entry]
Name=TickTick
Exec=$APPIMAGE_PATH --no-sandbox %U
Terminal=false
Type=Application
Icon=ticktick
StartupWMClass=ticktick
Comment=TickTick task management app
Categories=Office;
EOF

# Update desktop database
update-desktop-database "$DESKTOP_DIR"
gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

echo "TickTick installed successfully"

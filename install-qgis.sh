#!/bin/bash
set -e

# Install QGIS and its missing Qt6 dependency
echo "Installing QGIS..."
yay -S --noconfirm --needed qgis qt6-tools

# QGIS on Wayland: native Wayland support is still broken (toolbar dragging,
# color picker, dialog positioning), so we force XWayland via QT_QPA_PLATFORM=xcb.
#
# XWayland + Hyprland pointer bug: XWayland's pointer confinement causes the
# cursor to lock inside QGIS windows and snap to center at corners.
# Fix: set cursor:no_warps = true in Hyprland config.

# Desktop entry override — force XWayland mode
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"

cat > "$DESKTOP_DIR/org.qgis.qgis.desktop" << 'EOF'
[Desktop Entry]
Type=Application
Name=QGIS Desktop
GenericName=Geographic Information System
Icon=qgis
TryExec=qgis
Exec=env QT_QPA_PLATFORM=xcb qgis %F
Terminal=false
StartupNotify=false
Categories=Qt;Education;Science;Geography;
MimeType=application/x-qgis-project;application/x-qgis-project-container;application/x-qgis-layer-settings;application/x-qgis-layer-definition;application/x-qgis-composer-template;image/tiff;image/jpeg;image/jp2;application/x-raster-aig;application/x-raster-ecw;application/x-raster-mrsid;application/x-mapinfo-mif;application/x-esri-shape;application/vnd.google-earth.kml+xml;application/vnd.google-earth.kmz;application/geopackage+sqlite3;
Keywords=map;globe;postgis;wms;wfs;ogc;osgeo;
StartupWMClass=QGIS3
EOF

update-desktop-database "$DESKTOP_DIR"

# Fix cursor getting locked inside XWayland windows on Hyprland
if ! grep -q 'cursor:no_warps' ~/.config/hypr/input.conf 2>/dev/null; then
  echo "" >> ~/.config/hypr/input.conf
  echo "# Fix XWayland pointer confinement (cursor locks inside windows)" >> ~/.config/hypr/input.conf
  echo "cursor:no_warps = true" >> ~/.config/hypr/input.conf
fi

echo ""
echo "QGIS installed."
echo "  - Forced XWayland mode (native Wayland still broken)"
echo "  - cursor:no_warps enabled (fixes pointer locking in XWayland)"
echo ""
echo "Done!"

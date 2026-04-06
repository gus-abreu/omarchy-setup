#!/bin/bash
set -e

# Install QGIS LTS via Flatpak.
# Using LTS (3.x) instead of 4.x because key plugins (Planet Explorer) don't
# support Qt6/QGIS 4 yet. LTS 3.40 is supported through May 2026.
# Flatpak is required because Arch has dropped Qt5 dependencies needed by
# the native qgis-ltr AUR package.
echo "Installing QGIS LTS..."
flatpak install -y flathub org.qgis.qgis//stable

# QGIS on Wayland: native Wayland support is broken (toolbar dragging,
# color picker, dialog positioning), so we force XWayland via QT_QPA_PLATFORM=xcb.
#
# XWayland + Hyprland pointer bug: XWayland's pointer confinement causes the
# cursor to lock inside QGIS windows and snap to center at corners.
# Fix: set cursor:no_warps = true in Hyprland config.

# Desktop entry override — force XWayland mode
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"

# Get current monitor scale for XWayland scaling
SCALE=$(hyprctl monitors -j | jq -r '.[0].scale // 1.0')

cat > "$DESKTOP_DIR/org.qgis.qgis.desktop" << EOF
[Desktop Entry]
Type=Application
Name=QGIS Desktop
GenericName=Geographic Information System
Icon=org.qgis.qgis
TryExec=flatpak
Exec=env QT_SCALE_FACTOR=$SCALE flatpak run --env=QT_QPA_PLATFORM=xcb org.qgis.qgis
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
echo "QGIS LTS installed (Flatpak)."
echo "  - Forced XWayland mode (native Wayland still broken)"
echo "  - Scale factor: $SCALE"
echo "  - cursor:no_warps enabled (fixes pointer locking in XWayland)"
echo ""
echo "Done!"

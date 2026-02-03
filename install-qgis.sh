#!/bin/bash
set -e

# Install QGIS and OpenCL support for GPU acceleration
echo "Installing QGIS and OpenCL..."
yay -S --noconfirm --needed qgis opencl-mesa clinfo

# Create optimized desktop entry
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"

# Get current monitor scale for XWayland scaling
SCALE=$(hyprctl monitors -j | jq -r '.[0].scale // 1.0')

cat > "$DESKTOP_DIR/org.qgis.qgis.desktop" << EOF
[Desktop Entry]
Type=Application
Name=QGIS Desktop
GenericName=Geographic Information System
Icon=qgis
TryExec=qgis
Exec=env QT_QPA_PLATFORM=xcb QT_SCALE_FACTOR=$SCALE QGIS_PARALLEL_RENDERING=1 qgis %F
Terminal=false
StartupNotify=false
Categories=Qt;Education;Science;Geography;
MimeType=application/x-qgis-project;application/x-qgis-project-container;application/x-qgis-layer-settings;application/x-qgis-layer-definition;application/x-qgis-composer-template;image/tiff;image/jpeg;image/jp2;application/x-raster-aig;application/x-raster-ecw;application/x-raster-mrsid;application/x-mapinfo-mif;application/x-esri-shape;application/vnd.google-earth.kml+xml;application/vnd.google-earth.kmz;application/geopackage+sqlite3;
Keywords=map;globe;postgis;wms;wfs;ogc;osgeo;
StartupWMClass=QGIS3
EOF

update-desktop-database "$DESKTOP_DIR"

echo ""
echo "QGIS installed with optimizations:"
echo "  - XWayland mode (stable rendering)"
echo "  - Scale factor: $SCALE"
echo "  - Parallel rendering enabled"
echo ""
echo "OpenCL devices available:"
clinfo -l 2>/dev/null || echo "  Run 'clinfo' to verify OpenCL setup"
echo ""
echo "To enable GPU acceleration in QGIS:"
echo "  1. Open QGIS"
echo "  2. Go to Settings > Options > Acceleration"
echo "  3. Enable OpenCL acceleration"
echo ""
echo "Done!"

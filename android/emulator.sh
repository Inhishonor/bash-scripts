# This is a script that builds an image for an emulator on LineageOS. 
# Dependencies: LineageOS source code, and notify send.
#!/bin/bash
set -e

echo "This script builds and starts an eng emulator for x86_64"
echo "LineageOS must be fully synced and notify-send must be installed."

if ! command -v notify-send >/dev/null 2>&1; then
    echo "Notify-send is required but not installed."
    exit 1
fi

LINEAGE_DIR="${LINEAGE_DIR:-$HOME/android/lineage}"

cd "$LINEAGE_DIR" || { echo "LineageOS directory not found!"; exit 1; }

source build/envsetup.sh

croot


# Set Target
breakfast sdk_phone_x86_64 eng

# Build Image
mka
echo "Image built! Starting emulator..."

# Start Emulator
emulator | while read line; do
    echo "$line"
    if [[ "$line" == *"INFO | Boot completed in "* ]]; then
        # Send notification
        notify-send "Emulator Notification" "Emulator has started successfully!"
        break
    fi
done

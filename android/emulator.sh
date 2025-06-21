# This is a script that builds an image for an emulator on LineageOS. 
# Dependencies: LineageOS source code, and notify send.
echo "This script builds and starts an eng emulator for x86_64"
echo "LineageOS must be fully synced and notify-send must be installed."

# Navigate back to Lineage directory
cd ~/android/lineage

# Setup build environment
source build/envsetup.sh

# Make sure we are still in right directory
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

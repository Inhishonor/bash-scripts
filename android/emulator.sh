# This is a script that builds an image for an emulator on LineageOS.
echo "This script builds and starts an eng emulator for x86_64"

# Setup build environment
source build/envsetup.sh

# Set Target
breakfast sdk_phone_x86_64 eng

# Build Image
mka

# Start Emulator
emulator

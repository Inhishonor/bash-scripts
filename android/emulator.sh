# This is a script that builds an image for an emulator on LineageOS.
echo "This script builds and starts an eng emulator for x86_64"

# Navigate back to Lineage directory
cd android/lineage

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
emulator

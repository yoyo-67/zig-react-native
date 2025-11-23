#!/bin/bash

set -e

echo "Building Zig library for iOS..."

# Clean previous builds
rm -rf build/ios-arm64 build/ios-sim-arm64 build/ios-sim-x86_64
mkdir -p build/ios-arm64 build/ios-sim-arm64 build/ios-sim-x86_64

# Build for device (ARM64)
echo "Building for iOS device (ARM64)..."
zig build-lib src/lib.zig \
    -target aarch64-ios \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

mv libzig_backend.dylib build/ios-arm64/

# Build for simulator (ARM64 - M1/M2 Macs)
echo "Building for iOS simulator (ARM64)..."
zig build-lib src/lib.zig \
    -target aarch64-ios-simulator \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

mv libzig_backend.dylib build/ios-sim-arm64/

# Build for simulator (x86_64 - Intel Macs)
echo "Building for iOS simulator (x86_64)..."
zig build-lib src/lib.zig \
    -target x86_64-ios-simulator \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

mv libzig_backend.dylib build/ios-sim-x86_64/

# Create universal simulator library
echo "Creating universal simulator library..."
lipo -create \
    build/ios-sim-arm64/libzig_backend.dylib \
    build/ios-sim-x86_64/libzig_backend.dylib \
    -output build/libzig_backend_sim.dylib

echo "✅ iOS builds complete!"
echo "  - Device: build/ios-arm64/libzig_backend.dylib"
echo "  - Simulator: build/libzig_backend_sim.dylib"

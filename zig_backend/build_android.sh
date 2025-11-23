#!/bin/bash

set -e

echo "Building Zig library for Android..."

# Clean previous builds
rm -rf build/android
mkdir -p build/android/{arm64-v8a,armeabi-v7a,x86,x86_64}

# Build for ARM64 (most modern devices)
echo "Building for Android ARM64..."
zig build-lib src/lib.zig \
    -target aarch64-linux-android \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

mv libzig_backend.so build/android/arm64-v8a/

# Build for ARMv7 (older devices)
echo "Building for Android ARMv7..."
zig build-lib src/lib.zig \
    -target arm-linux-androideabi \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

mv libzig_backend.so build/android/armeabi-v7a/

# Build for x86_64 (emulators)
echo "Building for Android x86_64..."
zig build-lib src/lib.zig \
    -target x86_64-linux-android \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

mv libzig_backend.so build/android/x86_64/

# Build for x86 (older emulators)
echo "Building for Android x86..."
zig build-lib src/lib.zig \
    -target x86-linux-android \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

mv libzig_backend.so build/android/x86/

echo "✅ Android builds complete!"
echo "  - ARM64: build/android/arm64-v8a/libzig_backend.so"
echo "  - ARMv7: build/android/armeabi-v7a/libzig_backend.so"
echo "  - x86_64: build/android/x86_64/libzig_backend.so"
echo "  - x86: build/android/x86/libzig_backend.so"

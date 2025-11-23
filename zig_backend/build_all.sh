#!/bin/bash

set -e

echo "========================================"
echo "Building Zig Native Module for React Native"
echo "========================================"

# Clean previous builds
echo "Cleaning previous builds..."
rm -rf build
mkdir -p build

echo ""
echo "1️⃣  Building for iOS..."
echo "----------------------------------------"
./build_ios.sh

echo ""
echo "2️⃣  Building for Android..."
echo "----------------------------------------"
./build_android.sh

echo ""
echo "3️⃣  Generating header..."
echo "----------------------------------------"
./generate_header.sh

echo ""
echo "4️⃣  Copying to module directories..."
echo "----------------------------------------"

# iOS
echo "Copying iOS libraries..."
mkdir -p ../ios/zig
cp build/ios-arm64/libzig_backend.dylib ../ios/zig/
cp build/libzig_backend_sim.dylib ../ios/zig/
cp build/zig_backend.h ../ios/zig/

# Android
echo "Copying Android libraries..."
mkdir -p ../android/src/main/jniLibs/{arm64-v8a,armeabi-v7a,x86,x86_64}
cp build/android/arm64-v8a/libzig_backend.so ../android/src/main/jniLibs/arm64-v8a/
cp build/android/armeabi-v7a/libzig_backend.so ../android/src/main/jniLibs/armeabi-v7a/
cp build/android/x86/libzig_backend.so ../android/src/main/jniLibs/x86/
cp build/android/x86_64/libzig_backend.so ../android/src/main/jniLibs/x86_64/

echo ""
echo "========================================"
echo "✅ Build complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  • For iOS: cd ../ios && pod install"
echo "  • For Android: Build normally with Gradle"
echo ""

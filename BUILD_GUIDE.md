# Build Guide for Zig React Native Module

This guide provides detailed instructions for building the Zig native libraries for iOS and Android.

## Quick Start

If you have Zig installed:

```bash
cd zig_backend
./build_all.sh
```

## Installing Zig

### macOS

```bash
# Using Homebrew
brew install zig

# Or download directly
curl -O https://ziglang.org/download/0.13.0/zig-macos-aarch64-0.13.0.tar.xz
tar xf zig-macos-aarch64-0.13.0.tar.xz
sudo mv zig-macos-aarch64-0.13.0 /usr/local/zig
export PATH=$PATH:/usr/local/zig
```

### Linux

```bash
# Download and extract
wget https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz
tar xf zig-linux-x86_64-0.13.0.tar.xz
sudo mv zig-linux-x86_64-0.13.0 /usr/local/zig
export PATH=$PATH:/usr/local/zig

# Add to your shell profile
echo 'export PATH=$PATH:/usr/local/zig' >> ~/.bashrc
```

### Windows

```powershell
# Download from https://ziglang.org/download/
# Extract to C:\zig
# Add C:\zig to your PATH environment variable
```

### Verify Installation

```bash
zig version
# Should output: 0.13.0 or similar
```

## Building with Docker (Recommended)

If you don't want to install Zig locally, use Docker:

### Build All Platforms

```bash
docker run --rm -v $(pwd):/workspace -w /workspace/zig_backend \
  ziglang/zig:0.13.0 sh -c "./build_all.sh"
```

### Build iOS Only

```bash
docker run --rm -v $(pwd):/workspace -w /workspace/zig_backend \
  ziglang/zig:0.13.0 sh -c "./build_ios.sh && ./generate_header.sh"
```

### Build Android Only

```bash
docker run --rm -v $(pwd):/workspace -w /workspace/zig_backend \
  ziglang/zig:0.13.0 sh -c "./build_android.sh"
```

## Manual Build Steps

### iOS

```bash
cd zig_backend

# Build for device (ARM64)
zig build-lib src/lib.zig \
    -target aarch64-ios \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

# Build for simulator (ARM64 - M1/M2 Macs)
zig build-lib src/lib.zig \
    -target aarch64-ios-simulator \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

# Build for simulator (x86_64 - Intel Macs)
zig build-lib src/lib.zig \
    -target x86_64-ios-simulator \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

# Create universal simulator library
lipo -create \
    libzig_backend_sim_arm64.dylib \
    libzig_backend_sim_x86_64.dylib \
    -output libzig_backend_sim.dylib
```

### Android

```bash
cd zig_backend

# ARM64 (modern devices)
zig build-lib src/lib.zig \
    -target aarch64-linux-android \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

# ARMv7 (older devices)
zig build-lib src/lib.zig \
    -target arm-linux-androideabi \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

# x86_64 (emulators)
zig build-lib src/lib.zig \
    -target x86_64-linux-android \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend

# x86 (older emulators)
zig build-lib src/lib.zig \
    -target x86-linux-android \
    -O ReleaseFast \
    -dynamic \
    --name zig_backend
```

## Running Tests

```bash
cd zig_backend
zig build test
```

Expected output:
```
Test [1/3] test.zig_add... OK
Test [2/3] test.zig_multiply... OK
Test [3/3] test.zig_fibonacci... OK
All 3 tests passed.
```

## Verification

After building, verify the libraries exist:

### iOS

```bash
ls -lh zig_backend/build/
# Should see:
# ios-arm64/libzig_backend.dylib
# libzig_backend_sim.dylib
# zig_backend.h
```

### Android

```bash
ls -lh zig_backend/build/android/
# Should see:
# arm64-v8a/libzig_backend.so
# armeabi-v7a/libzig_backend.so
# x86_64/libzig_backend.so
# x86/libzig_backend.so
```

## Integration After Building

### iOS

```bash
cd ios
pod install
```

### Android

The libraries are automatically included when building with Gradle.

## Troubleshooting

### "zig: command not found"

- Make sure Zig is installed and in your PATH
- Try `which zig` to verify
- Or use the Docker method

### "lipo: can't open input file"

- Make sure you've built all the iOS variants first
- Check that the .dylib files exist in the expected locations

### Build fails on macOS

- Make sure you have Xcode Command Line Tools installed:
  ```bash
  xcode-select --install
  ```

### Build fails on Linux

- Make sure you have build essentials installed:
  ```bash
  sudo apt-get install build-essential
  ```

### Permission denied on build scripts

```bash
chmod +x zig_backend/*.sh
```

## CI/CD Integration

### GitHub Actions

```yaml
name: Build Zig Libraries

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Zig
        uses: goto-bus-stop/setup-zig@v2
        with:
          version: 0.13.0

      - name: Build libraries
        run: |
          cd zig_backend
          ./build_all.sh

      - name: Run tests
        run: |
          cd zig_backend
          zig build test
```

## Build Options

### Optimization Levels

- `ReleaseFast` - Maximum performance (default)
- `ReleaseSafe` - Performance with safety checks
- `ReleaseSmall` - Optimize for size
- `Debug` - No optimization, full debug info

Example:
```bash
zig build-lib src/lib.zig -target aarch64-ios -O ReleaseSmall -dynamic --name zig_backend
```

### Debug Build

```bash
zig build-lib src/lib.zig \
    -target aarch64-ios \
    -O Debug \
    -dynamic \
    --name zig_backend
```

## Clean Build

```bash
cd zig_backend
rm -rf build zig-cache zig-out
./build_all.sh
```

## Next Steps

After successfully building:

1. For iOS: Run `pod install` in the ios/ directory
2. For Android: Build your app normally with Gradle
3. Test the module with the example app
4. Verify performance benchmarks

## Support

If you encounter issues:
1. Check that Zig version is 0.13.0 or later
2. Verify all build scripts are executable
3. Try the Docker method if local builds fail
4. Check the main README.md for additional troubleshooting

# Quick Start Guide

Get up and running with Zig React Native in 5 minutes!

## Prerequisites Check

- [ ] Node.js installed (`node --version`)
- [ ] For iOS: macOS with Xcode
- [ ] For Android: Android Studio and NDK
- [ ] Zig compiler (see installation below)

## Step 1: Install Zig

### macOS (fastest method)
```bash
brew install zig
```

### Linux
```bash
wget https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz
tar xf zig-linux-x86_64-0.13.0.tar.xz
sudo mv zig-linux-x86_64-0.13.0 /usr/local/zig
export PATH=$PATH:/usr/local/zig
```

### Or use Docker (no installation needed!)
```bash
# Build using Docker - works on any platform
docker run --rm -v $(pwd):/workspace -w /workspace/zig_backend \
  ziglang/zig:0.13.0 sh -c "./build_all.sh"
```

## Step 2: Clone or Install

```bash
# If installing as a package
npm install zig-react-native

# If developing locally
git clone <your-repo>
cd zig-react-native
npm install
```

## Step 3: Build Native Libraries

```bash
cd zig_backend
./build_all.sh
```

You should see:
```
✅ iOS builds complete!
✅ Android builds complete!
✅ Header generated!
✅ Build complete!
```

## Step 4: Platform Setup

### For iOS

```bash
cd ios
pod install
cd ..
```

### For Android

No additional steps needed! Libraries are ready to use.

## Step 5: Test It!

Run the example app:

```bash
cd example
npm install
npm start
```

Then:
- Press `i` for iOS simulator
- Press `a` for Android emulator

## Verify Installation

Create a test file `test.js`:

```javascript
const { zigAdd, zigMultiply, zigFibonacci } = require('zig-react-native');

console.log('zigAdd(5, 10) =', zigAdd(5, 10));           // 15
console.log('zigMultiply(7, 8) =', zigMultiply(7, 8));   // 56
console.log('zigFibonacci(10) =', zigFibonacci(10));     // 55
```

Run it:
```bash
node test.js
```

## Common Issues

### "zig: command not found"

Zig is not installed or not in PATH. Either:
- Install Zig following Step 1 above
- Use Docker method (no installation needed)

### iOS: "library not loaded"

```bash
cd ios
pod install
```

### Android: "UnsatisfiedLinkError"

```bash
cd zig_backend
./build_android.sh
```

### Build script permission denied

```bash
chmod +x zig_backend/*.sh
```

## What's Next?

- 📖 Read the [README](README.md) for full documentation
- 🏗️ See [BUILD_GUIDE](BUILD_GUIDE.md) for advanced build options
- 💡 Check the [example app](example/App.tsx) for usage patterns
- 🚀 Start building your own high-performance native functions!

## Adding Your Own Functions

1. Edit `zig_backend/src/lib.zig`
2. Run `./build_all.sh`
3. Update the TypeScript interface
4. Use in your app!

See README.md "Adding New Functions" section for details.

## Performance Tips

The example app includes a performance benchmark. On a typical device:

- **Addition**: ~1,000,000 ops/ms
- **Multiplication**: ~1,000,000 ops/ms
- **Fibonacci(20)**: ~50,000 ops/ms

Zig provides native performance with zero overhead!

## Getting Help

- 📝 Check [BUILD_GUIDE.md](BUILD_GUIDE.md) for build issues
- 🐛 Report issues on GitHub
- 💬 Ask questions in discussions

## Success Checklist

After completing these steps, you should have:

- [x] Zig installed (or using Docker)
- [x] Native libraries built in `zig_backend/build/`
- [x] iOS libraries in `ios/zig/`
- [x] Android libraries in `android/src/main/jniLibs/`
- [x] Example app running
- [x] All tests passing

Enjoy building high-performance React Native apps with Zig! 🚀

# Quick Clone and Run Commands

## 🚀 One-Line Quick Start (macOS with Homebrew)

```bash
git clone <your-repo-url> && cd zig-react-native && brew install zig && cd zig_backend && ./build_all.sh && cd ../example && npm install && npm start
```

## 📋 Step-by-Step Commands

### Clone the Repository

```bash
git clone <your-repo-url>
cd zig-react-native
```

### Option 1: macOS (Fastest)

```bash
# Install Zig
brew install zig

# Build native libraries
cd zig_backend
./build_all.sh

# Install and run example
cd ../example
npm install
npm start

# Press 'i' for iOS simulator
# Press 'a' for Android emulator
```

### Option 2: Linux

```bash
# Install Zig
wget https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz
tar xf zig-linux-x86_64-0.13.0.tar.xz
sudo mv zig-linux-x86_64-0.13.0 /usr/local/zig
export PATH=$PATH:/usr/local/zig

# Build native libraries
cd zig_backend
./build_all.sh

# Install and run example
cd ../example
npm install
npm start

# Press 'i' for iOS simulator (if on macOS)
# Press 'a' for Android emulator
```

### Option 3: Docker (Works Everywhere - No Zig Install!)

```bash
# Build with Docker
cd zig_backend
docker run --rm -v $(pwd):/workspace -w /workspace ziglang/zig:0.13.0 sh -c "./build_all.sh"

# Install and run example
cd ../example
npm install
npm start

# Press 'i' for iOS simulator
# Press 'a' for Android emulator
```

## 🎯 Just Want to See the Code?

### Quick File Tour

```bash
# View the main Zig code
cat zig_backend/src/lib.zig

# View iOS integration
cat ios/ZigReactNativeModule.swift

# View Android integration
cat android/src/main/java/expo/modules/zigreactnative/ZigReactNativeModule.kt

# View TypeScript interface
cat src/index.ts

# View example app
cat example/App.tsx
```

### Open in Your Editor

```bash
# VS Code
code .

# Vim
vim .

# Any editor
open .  # macOS
xdg-open .  # Linux
```

## 🧪 Quick Test (Without Building)

Just want to see if the code is valid?

```bash
# Test Zig syntax (requires Zig)
cd zig_backend
zig build test

# You should see:
# Test [1/3] test.zig_add... OK
# Test [2/3] test.zig_multiply... OK
# Test [3/3] test.zig_fibonacci... OK
# All 3 tests passed.
```

## 📱 Platform-Specific Setup

### For iOS (macOS only)

```bash
# After building libraries
cd ios
pod install
cd ..

# Run on iOS
cd example
npm run ios
```

### For Android

```bash
# After building libraries
cd example
npm run android
```

## 🔍 Verify Build Success

```bash
# Check iOS libraries exist
ls -lh ios/zig/
# Should see: libzig_backend.dylib, libzig_backend_sim.dylib, zig_backend.h

# Check Android libraries exist
find android/src/main/jniLibs -name "*.so"
# Should see 4 .so files (arm64-v8a, armeabi-v7a, x86, x86_64)
```

## 🎮 Interactive Demo

Once the example app is running:

1. **Run Tests** - Click to see all three functions work
2. **Run Performance Test** - Benchmark 1M+ operations
3. **View Results** - See output in scrollable window

Functions available:
- `zigAdd(5, 10)` → 15
- `zigMultiply(7, 8)` → 56
- `zigFibonacci(10)` → 55

## ⚡ Super Quick (Copy-Paste Ready)

### macOS
```bash
git clone <repo-url> zig-rn && cd zig-rn && brew install zig && cd zig_backend && ./build_all.sh && cd ../example && npm install && npm start
```

### Linux with Docker
```bash
git clone <repo-url> zig-rn && cd zig-rn/zig_backend && docker run --rm -v $(pwd):/workspace -w /workspace ziglang/zig:0.13.0 sh -c "./build_all.sh" && cd ../example && npm install && npm start
```

## 📚 More Information

- `README.md` - Full documentation
- `QUICK_START.md` - 5-minute guide
- `BUILD_GUIDE.md` - Detailed build instructions
- `BUILD_VERIFICATION.md` - Code verification report

## ❓ Troubleshooting

**"zig: command not found"**
→ Install Zig or use Docker method

**"library not loaded" on iOS**
→ Run `cd ios && pod install`

**"UnsatisfiedLinkError" on Android**
→ Rebuild libraries: `cd zig_backend && ./build_all.sh`

**Script permission denied**
→ Run `chmod +x zig_backend/*.sh`

---

Happy coding! 🚀

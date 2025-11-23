# Zig React Native Module

A high-performance React Native module powered by Zig for iOS and Android. This module demonstrates how to use Zig as a native backend for React Native, offering excellent performance, small binary sizes, and simple C interoperability without FFI layers.

## Why Zig?

Zig is a modern systems programming language that offers several advantages for React Native development:

- **Simple C interoperability** - No FFI layer needed
- **Compile-time execution** and optimization
- **No hidden control flow** or allocations
- **Built-in cross-compilation** for all platforms
- **Memory safety** without a runtime
- **Smaller binaries** than Rust (typically 50-70% smaller)
- **Direct platform compatibility** - Works seamlessly with iOS and Android

Unlike Rust which requires FFI bindings, Zig can directly expose C-compatible functions using the `export` keyword, making it ideal for React Native integration.

## Prerequisites

- Node.js and npm
- Zig compiler (install from https://ziglang.org/download/)
- For iOS development:
  - macOS with Xcode
  - CocoaPods
- For Android development:
  - Android Studio
  - Android NDK

## Installation

```bash
npm install zig-react-native
```

Or with yarn:

```bash
yarn add zig-react-native
```

## Building the Native Libraries

Before using the module, you need to build the Zig native libraries:

```bash
cd node_modules/zig-react-native/zig_backend
./build_all.sh
```

This will build the libraries for all platforms:
- iOS (device and simulator)
- Android (ARM64, ARMv7, x86, x86_64)

### Platform-Specific Builds

If you only need to build for a specific platform:

**iOS only:**
```bash
cd zig_backend
./build_ios.sh
./generate_header.sh
```

**Android only:**
```bash
cd zig_backend
./build_android.sh
```

### iOS Setup

After building, install the iOS dependencies:

```bash
cd ios
pod install
```

## Usage

Import the module in your React Native code:

```typescript
import { zigAdd, zigMultiply, zigFibonacci } from 'zig-react-native';

// Add two numbers
const sum = zigAdd(5, 10);
console.log(sum); // 15

// Multiply two numbers
const product = zigMultiply(7, 8);
console.log(product); // 56

// Calculate Fibonacci number
const fib = zigFibonacci(10);
console.log(fib); // 55
```

## API Reference

### `zigAdd(a: number, b: number): number`

Adds two integers using native Zig implementation.

**Parameters:**
- `a` - First number
- `b` - Second number

**Returns:** Sum of a and b

### `zigMultiply(a: number, b: number): number`

Multiplies two integers using native Zig implementation.

**Parameters:**
- `a` - First number
- `b` - Second number

**Returns:** Product of a and b

### `zigFibonacci(n: number): number`

Calculates the nth Fibonacci number using native Zig implementation.

**Parameters:**
- `n` - The position in the Fibonacci sequence (0-indexed)

**Returns:** The nth Fibonacci number

## Development

### Project Structure

```
zig-react-native/
├── android/                      # Android native module
│   ├── build.gradle
│   └── src/main/
│       ├── AndroidManifest.xml
│       ├── java/expo/modules/zigreactnative/
│       │   └── ZigReactNativeModule.kt
│       └── jniLibs/             # Native libraries for Android
├── ios/                         # iOS native module
│   ├── ZigReactNativeModule.swift
│   ├── ZigReactNative-Bridging-Header.h
│   └── zig/                     # Native libraries for iOS
├── src/                         # TypeScript source
│   └── index.ts
├── zig_backend/                 # Zig source code
│   ├── src/
│   │   └── lib.zig             # Main Zig library
│   ├── build.zig               # Zig build configuration
│   ├── build_ios.sh            # iOS build script
│   ├── build_android.sh        # Android build script
│   ├── generate_header.sh      # Generate C header
│   └── build_all.sh            # Complete build script
├── package.json
├── tsconfig.json
└── ZigReactNative.podspec      # iOS pod specification
```

### Adding New Functions

1. Add your function to `zig_backend/src/lib.zig`:

```zig
export fn my_function(param: i32) i32 {
    // Your implementation
    return param * 2;
}

// Android JNI binding
export fn Java_expo_modules_zigreactnative_ZigReactNativeModule_myFunction(
    env: *anyopaque,
    class: *anyopaque,
    param: i32,
) i32 {
    _ = env;
    _ = class;
    return my_function(param);
}
```

2. Update the C header in `generate_header.sh`:

```c
int32_t my_function(int32_t param);
```

3. Add to iOS module (`ios/ZigReactNativeModule.swift`):

```swift
Function("myFunction") { (param: Int32) -> Int32 in
  return my_function(param)
}
```

4. Add to Android module (`android/src/main/java/expo/modules/zigreactnative/ZigReactNativeModule.kt`):

```kotlin
Function("myFunction") { param: Int ->
  myFunction(param)
}

private external fun myFunction(param: Int): Int
```

5. Add to TypeScript interface (`src/index.ts`):

```typescript
export function myFunction(param: number): number {
  return ZigReactNativeModule.myFunction(param);
}
```

6. Rebuild the libraries:

```bash
cd zig_backend
./build_all.sh
```

### Running Tests

The Zig library includes unit tests:

```bash
cd zig_backend
zig build test
```

## Performance

Zig offers excellent performance characteristics:

- **Native speed** - Compiles to optimized machine code
- **Zero runtime overhead** - No garbage collection or runtime
- **Small binaries** - Significantly smaller than equivalent Rust implementations
- **Efficient cross-compilation** - Single toolchain for all platforms

## Advantages Over Rust for React Native

1. **No FFI Layer Required** - Zig's `export` keyword generates C-compatible functions directly
2. **Simpler Build Process** - No need for complex Cargo configurations
3. **Built-in Cross-compilation** - One compiler handles all target platforms
4. **Smaller Binary Size** - Typically 50-70% smaller than equivalent Rust code
5. **Zero Runtime** - Pure native code with no runtime dependencies
6. **Easier JNI** - Direct C compatibility simplifies Android integration
7. **Compile-time Execution** - Zero-cost abstractions through comptime

## Troubleshooting

### iOS: Library not loaded

If you get a "library not loaded" error on iOS:
1. Make sure you've run the build script: `cd zig_backend && ./build_all.sh`
2. Run `pod install` in the ios/ directory
3. Clean and rebuild your iOS project

### Android: UnsatisfiedLinkError

If you get an UnsatisfiedLinkError on Android:
1. Verify the library name matches: `System.loadLibrary("zig_backend")`
2. Check that JNI function signatures are correct
3. Ensure libraries are in the correct `jniLibs` folders
4. Rebuild: `cd zig_backend && ./build_all.sh`

### Zig Not Found

Make sure Zig is properly installed:
```bash
zig version
```

If not installed, download from https://ziglang.org/download/

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Resources

- [Zig Documentation](https://ziglang.org/documentation/master/)
- [React Native Documentation](https://reactnative.dev/)
- [Expo Modules API](https://docs.expo.dev/modules/overview/)

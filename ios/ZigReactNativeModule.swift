import ExpoModulesCore

public class ZigReactNativeModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ZigReactNative")

    // Add function
    Function("zigAdd") { (a: Int32, b: Int32) -> Int32 in
      return zig_add(a, b)
    }

    // Multiply function
    Function("zigMultiply") { (a: Int32, b: Int32) -> Int32 in
      return zig_multiply(a, b)
    }

    // Fibonacci function
    Function("zigFibonacci") { (n: Int32) -> Int32 in
      return zig_fibonacci(n)
    }
  }
}

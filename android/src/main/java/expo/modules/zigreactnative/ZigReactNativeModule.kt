package expo.modules.zigreactnative

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

class ZigReactNativeModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("ZigReactNative")

    // Add function
    Function("zigAdd") { a: Int, b: Int ->
      zigAdd(a, b)
    }

    // Multiply function
    Function("zigMultiply") { a: Int, b: Int ->
      zigMultiply(a, b)
    }

    // Fibonacci function
    Function("zigFibonacci") { n: Int ->
      zigFibonacci(n)
    }
  }

  companion object {
    init {
      System.loadLibrary("zig_backend")
    }
  }

  // Native method declarations
  private external fun zigAdd(a: Int, b: Int): Int
  private external fun zigMultiply(a: Int, b: Int): Int
  private external fun zigFibonacci(n: Int): Int
}

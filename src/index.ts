import { requireNativeModule } from 'expo-modules-core';

// Define the native module type
type ZigReactNativeModuleType = {
  zigAdd(a: number, b: number): number;
  zigMultiply(a: number, b: number): number;
  zigFibonacci(n: number): number;
};

// Get the native module
const ZigReactNativeModule = requireNativeModule<ZigReactNativeModuleType>('ZigReactNative');

/**
 * Add two numbers using Zig native implementation
 * @param a First number
 * @param b Second number
 * @returns Sum of a and b
 */
export function zigAdd(a: number, b: number): number {
  return ZigReactNativeModule.zigAdd(a, b);
}

/**
 * Multiply two numbers using Zig native implementation
 * @param a First number
 * @param b Second number
 * @returns Product of a and b
 */
export function zigMultiply(a: number, b: number): number {
  return ZigReactNativeModule.zigMultiply(a, b);
}

/**
 * Calculate the nth Fibonacci number using Zig native implementation
 * @param n The position in the Fibonacci sequence (0-indexed)
 * @returns The nth Fibonacci number
 */
export function zigFibonacci(n: number): number {
  return ZigReactNativeModule.zigFibonacci(n);
}

// Export the module type for advanced users
export type { ZigReactNativeModuleType };

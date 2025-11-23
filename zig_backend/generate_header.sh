#!/bin/bash

set -e

echo "Generating C header for iOS..."

mkdir -p build

cat > build/zig_backend.h << 'EOF'
#ifndef ZIG_BACKEND_H
#define ZIG_BACKEND_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Add two 32-bit integers
 * @param a First integer
 * @param b Second integer
 * @return Sum of a and b
 */
int32_t zig_add(int32_t a, int32_t b);

/**
 * Multiply two 32-bit integers
 * @param a First integer
 * @param b Second integer
 * @return Product of a and b
 */
int32_t zig_multiply(int32_t a, int32_t b);

/**
 * Calculate the nth Fibonacci number
 * @param n The position in the Fibonacci sequence (0-indexed)
 * @return The nth Fibonacci number
 */
int32_t zig_fibonacci(int32_t n);

#ifdef __cplusplus
}
#endif

#endif // ZIG_BACKEND_H
EOF

echo "✅ Header generated at build/zig_backend.h"

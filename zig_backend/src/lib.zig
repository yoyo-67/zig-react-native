const std = @import("std");

// Core functions - work on all platforms
export fn zig_add(a: i32, b: i32) i32 {
    return a + b;
}

export fn zig_multiply(a: i32, b: i32) i32 {
    return a * b;
}

export fn zig_fibonacci(n: i32) i32 {
    if (n <= 1) return n;

    var prev: i32 = 0;
    var curr: i32 = 1;
    var i: i32 = 2;

    while (i <= n) : (i += 1) {
        const next = prev + curr;
        prev = curr;
        curr = next;
    }

    return curr;
}

// Android JNI bindings
// The export makes it C-compatible, no FFI needed!
export fn Java_expo_modules_zigreactnative_ZigReactNativeModule_zigAdd(
    env: *anyopaque,
    class: *anyopaque,
    a: i32,
    b: i32,
) i32 {
    _ = env;
    _ = class;
    return zig_add(a, b);
}

export fn Java_expo_modules_zigreactnative_ZigReactNativeModule_zigMultiply(
    env: *anyopaque,
    class: *anyopaque,
    a: i32,
    b: i32,
) i32 {
    _ = env;
    _ = class;
    return zig_multiply(a, b);
}

export fn Java_expo_modules_zigreactnative_ZigReactNativeModule_zigFibonacci(
    env: *anyopaque,
    class: *anyopaque,
    n: i32,
) i32 {
    _ = env;
    _ = class;
    return zig_fibonacci(n);
}

// Tests
test "zig_add" {
    try std.testing.expectEqual(@as(i32, 15), zig_add(5, 10));
    try std.testing.expectEqual(@as(i32, 0), zig_add(-5, 5));
    try std.testing.expectEqual(@as(i32, -10), zig_add(-5, -5));
}

test "zig_multiply" {
    try std.testing.expectEqual(@as(i32, 50), zig_multiply(5, 10));
    try std.testing.expectEqual(@as(i32, -25), zig_multiply(-5, 5));
    try std.testing.expectEqual(@as(i32, 25), zig_multiply(-5, -5));
}

test "zig_fibonacci" {
    try std.testing.expectEqual(@as(i32, 0), zig_fibonacci(0));
    try std.testing.expectEqual(@as(i32, 1), zig_fibonacci(1));
    try std.testing.expectEqual(@as(i32, 1), zig_fibonacci(2));
    try std.testing.expectEqual(@as(i32, 2), zig_fibonacci(3));
    try std.testing.expectEqual(@as(i32, 3), zig_fibonacci(4));
    try std.testing.expectEqual(@as(i32, 5), zig_fibonacci(5));
    try std.testing.expectEqual(@as(i32, 8), zig_fibonacci(6));
    try std.testing.expectEqual(@as(i32, 55), zig_fibonacci(10));
}

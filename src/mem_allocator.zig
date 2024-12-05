// An allocator is a struct that implements a set of functions
// that allow you to allocate and deallocate memory
const std = @import("std");

// This will allocate 100 bytes of memory using the page allocator and then free it when the function exits.
pub fn page_allocator() !void {
    var buffer: [1048]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);

    const allocator = fba.allocator();

    const memory: []u8 = try allocator.alloc(u8, 255);
    defer allocator.free(memory);
}

pub fn arena_allocator() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const memory1: []u8 = try allocator.alloc(u8, 25);
    const memory2: []u8 = try allocator.alloc(u8, 2);
    const memory3: []u8 = try allocator.alloc(u8, 1);

    // to avoid the unused variable error, we can use the _ operator
    _ = memory1;
    _ = memory2;
    _ = memory3;
}

const std = @import("std");
const expect = std.testing.expect;

test "Always succeeds" {
    try expect(true);
}

test "Always fail" {
    try expect(false);
}

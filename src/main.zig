const std = @import("std");
const user = @import("models/user.zig").User;
// Functions that begin with @ are builtin functions. They are provided by the compiler as opposed to the standard library.

pub fn main() !void {
    const angi_name: *const [8:0]u8 = "Angelica";
    const carlos_name: *const [6:0]u8 = "Carlos";
    std.debug.print("{s} and {s} are a couple <3\n", .{ angi_name, carlos_name });

    const age: u8 = 21;
    const angi_curp: [5]u8 = [5]u8{ 'A', 'N', 'G', 'I', 'A' };
    const angi: user = user.create_user(angi_name, angi_curp, age);
    // user.get_user(angi);

    const my_age: u8 = 20;
    const carlos_curp: [5]u8 = [5]u8{ 'C', 'A', 'R', 'L', 'O' };
    const carlinux: user = user.create_user(carlos_name, carlos_curp, my_age);

    // Fixed size
    const couple = [2]user{ angi, carlinux };
    _ = couple;

    // try alloc_users(couple);

    // Dynamic size
    var allocator = std.heap.page_allocator;
    var couple_with_allocator = try allocator.alloc(user, 2);
    defer allocator.free(couple_with_allocator);

    couple_with_allocator[0] = angi;
    couple_with_allocator[1] = carlinux;

    try alloc_users(couple_with_allocator);

    // try alloc_users(angi);
    // try alloc_users(carlinux);

    // zig_arrays();
    // zig_for();
}

// If we want to do it in a dynamic way, we use []user
// Or we can do it with a fixed size with [2]user
fn alloc_users(my_user: []user) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const user_allocator = try allocator.alloc(user, 2);
    defer allocator.free(user_allocator);

    for (0..user_allocator.len, 0..) |_, index| {
        user_allocator[index] = my_user[index];
    }
    std.debug.print("Allocated slice: {any}\n", .{user_allocator});

    for (0..my_user.len, 0..) |_, index| {
        std.debug.print("Name: {s}, curp: {c}, age: {d}\n", .{ my_user[index].name, my_user[index].curp, my_user[index].age });
    }
}

fn zig_arrays() void {
    const phrase: [8]u8 = [8]u8{ 'I', 'L', 'O', 'V', 'E', 'Y', 'O', 'U' };
    const second_phrase = [_]u8{ 'F', 'O', 'R', 'E', 'V', 'E', 'R' };

    const phrase_len = phrase.len; // 8

    std.debug.print("{c} \n {c} \n", .{ phrase, second_phrase });

    std.debug.print("Phrase len -> {d}\n", .{phrase_len});
}

fn zig_for() void {
    const phrase: [8]u8 = [8]u8{ 'I', 'L', 'O', 'V', 'E', 'Y', 'O', 'U' };
    const second_phrase = [_]u8{ 'F', 'O', 'R', 'E', 'V', 'E', 'R' };

    for (phrase) |character| {
        std.debug.print("{c} ", .{character});
    }

    for (second_phrase) |character| {
        std.debug.print("{c}", .{character});
    }
}

const std = @import("std");

pub const User: type = struct {
    name: []const u8,
    curp: [5]u8,
    age: u8,

    pub fn create_user(name: []const u8, curp: [5]u8, age: u8) User {
        const my_user = User{
            .name = name,
            .curp = curp,
            .age = age,
        };
        return my_user;
    }

    pub fn get_user(my_user: User) void {
        std.debug.print("User's name: {s}, curp: {c}, and it's age: {d}\n", .{ my_user.name, my_user.curp, my_user.age });
    }
};

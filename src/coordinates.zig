const particular = @import("root.zig");
const std = @import("std");

pub fn Vec2(comptime T: type) type {
    return struct {
        const Self = @This();
    pos: @Vector(2,T),
    
    pub fn init(x:T,y:T) Self {
        return .{.pos = .{x,y}};
    }

    pub fn add(self: Self, other: Self) Self {
        return Self.init(self.pos[0] + other.pos[0], self.pos[1] + other.pos[1]);
    }
    
    pub fn addNum(self: Self, other: anytype) Self {
        return Self.init(self.pos[0] + other, self.pos[1] + other);
    }
    pub fn negate(self: Self) Self {
        return Self.init(-self.pos[0], -self.pos[1]);
    }
    };
}


const std = @import("std");
const ev = @import("event.zig");
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});

pub const Vec2 = struct{
    pos: @Vector(2,i32),
    
    pub fn init(x:i32,y:i32) Vec2 {
        return .{.pos = .{x,y}};
    }

    pub fn add(self: Vec2, other: Vec2) Vec2 {
        return Vec2.init(self.pos[0] + other.pos[0], self.pos[1] + other.pos[1]);
    }

    pub fn negate(self: Vec2) Vec2 {
        return Vec2.init(-self.pos[0], -self.pos[1]);
    }
};
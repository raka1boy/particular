const std = @import("std");
const particular = @import("root.zig");
const Vec2 = particular.Vec2;
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});

pub fn Object(comptime T: type, ) type {
    return struct {
        const Self = @This();
        pos:Vec2(T),

        pub fn initWithPos(pos:Vec2(T)) Self {
            return .{.pos = pos};   
        }
        pub fn teleportTo(self: *Self,new_pos:Vec2(T)) void {
            self.pos = new_pos;
        }
        pub fn moveTowards(self: *Self,dest:Vec2(T),speed:u32) void {
            _ = self;
            _ = dest;
            _ = speed;
            unreachable;
        }
    };
}
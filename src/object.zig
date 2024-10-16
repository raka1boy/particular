const std = @import("std");
const ev = @import("event.zig");
const Vec2 = @import("coordinates.zig").Vec2;
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});

pub const Object = struct {
    pos:Vec2,

    pub fn teleportTo(self: *Object,new_pos:Vec2) void {
        self.pos = new_pos;
    }
    pub fn moveTowards(self: *Object,dest:Vec2,speed:u32) void {
        
    }
};
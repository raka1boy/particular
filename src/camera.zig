const std = @import("std");
const ev = @import("event.zig");
const Object = @import("object.zig").Object;
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});
pub const Camera = struct {
    pos:Vec2
};
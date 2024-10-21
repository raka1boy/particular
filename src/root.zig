pub const std = @import("std");
pub const gamehandler = @import("game_handler.zig");
pub const GameHandler = gamehandler.GameHandler;
pub const Camera = @import("camera.zig").Camera;
pub const Material = gamehandler.Material;
pub const color = @import("colors.zig");
pub const Vec2 = @import("coordinates.zig").Vec2;
pub const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});
const std = @import("std");
const gh = @import("game_handler.zig");
const GameHandler = gh.GameHandler;
//const SurroundingsHandle = gh.
const Material = SurrHandle.Material;
const col = @import("colors.zig");
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});
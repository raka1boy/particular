const std = @import("std");
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
});
const StaticColor = @Vector(u8,3);
const Color = extern union(enum) {
    static:StaticColor,
    variation: [5]StaticColor,
}

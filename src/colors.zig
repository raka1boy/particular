const std = @import("std");
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
});
const StaticColor = @Vector(4,u8);
const Color = extern union(enum) {
    static:StaticColor,
    gradient: [2]StaticColor,
};
pub fn staticColor(r:u8, g:u8, b:u8, a:u8) Color.StaticColor {
    return @Vector(4,u8){r,g,b,a};
}
    
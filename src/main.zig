const std = @import("std");
const GameHandler = @import("game_handler.zig").GameHandler;
const SurrHandle = @import("surroundings_handle.zig");
const Material = SurrHandle.Material;
const Color = @import("colors.zig").Color;
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});

const Materials = [_]Material{
    .{1,},

}

pub fn main() !void {
    var gh = try GameHandler.init();
    defer gh.deinit();
    
    while(gh.running) {
        gh.update();
        handleEvents(&gh);
    }
}

fn handleEvents(gamestate: *GameHandler) void {
    const event_type = gamestate.current_event.getType();

    if(event_type == c.SDL_EVENT_MOUSE_MOTION) {
        std.debug.print("{any}\n", .{gamestate.*.camera.getMousePos()});
    }

}
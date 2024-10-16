//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const std = @import("std");
const GameHandler = @import("game_handler.zig").GameHandler;
const ev = @import("event.zig");
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});

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
        std.debug.print("1", .{});
    }

}
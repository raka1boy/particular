const std = @import("std");
const particular = @import("root.zig");
const Material = particular.Material;
const col = particular.Color;
const GameHandler = particular.GameHandler;
const c = particular.c;
const Materials = [_]Material{
    .{1,col.staticColor(50,50,50,255), },
};
const win_name = "sex gifs";
const win_width = 800;
const win_height = 600;
pub fn main() !void {
    var gh = try GameHandler.init(win_name,win_height,win_width);
    defer gh.deinit();
    
    while(gh.running) {
        gh.update();
        handleEvents(&gh);
    }
}

fn handleEvents(gamestate: *GameHandler) void {
    const event_type = gamestate.current_event.type;

    if(event_type == c.SDL_EVENT_MOUSE_MOTION) {
        std.debug.print("{any}\n", .{gamestate.*.camera.getMousePos()});
    }

}
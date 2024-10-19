const std = @import("std");
const particular = @import("root");
const Material = particular.Material;
const col = particular.Color;
const GameHandler = particular.GameHandler;
const Materials = [_]Material{
    .{1,col.staticColor(50,50,50,255), },
};

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
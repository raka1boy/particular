const std = @import("std");
const ev = @import("event.zig");
const Camera = @import("camera.zig").Camera;
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});
pub const SDLErrors = error {
    SdlInitError,
    SdlInitWindowError,
};
//pub const eventHandlerFunc = *const fn (state: *GameHandler) !void; 
pub const GameHandler = struct{
    window: *c.SDL_Window,
    camera: Camera = Camera.initAtZero(),
    current_event: ev.Event = undefined,
    running: bool = true,


    pub fn init() !GameHandler {
        if(!c.SDL_Init(c.SDL_INIT_VIDEO)) {
            c.SDL_LogError(c.SDL_LOG_CATEGORY_APPLICATION, "SDL_Init failed: %s", c.SDL_GetError());
            return SDLErrors.SdlInitError;
        }
        const window = c.SDL_CreateWindow("SDL3 Vulkan Example", 
        800, 600, 
        c.SDL_WINDOW_VULKAN) orelse {
            c.SDL_LogError(c.SDL_LOG_CATEGORY_APPLICATION, "SDL_CreateWindow failed: %s", c.SDL_GetError());
            c.SDL_Quit();
            return SDLErrors.SdlInitWindowError;
        };

        return .{.window = window};
    }

    pub fn update(self: *GameHandler) void {
        self.current_event.poll();
        if(self.current_event.getType() == c.SDL_EVENT_QUIT) {self.deinit(); self.running = false;}
    }

    pub fn deinit(self: *GameHandler) void {
        c.SDL_DestroyWindow(self.window);
        c.SDL_Quit();
    }
};
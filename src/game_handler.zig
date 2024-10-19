const std = @import("std");
const ev = @import("event.zig");
const Camera = @import("camera.zig").Camera;
const col = @import("color.zig");
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
    current_event: Event = undefined,
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
const MouseEvent = enum(u32) {
    LMBClicked,
    RMBClicked,
    WheelClicked,
    WheelRotated,
    OtherButtonClicked
};
const EventType = union(enum) {
    MouseEvent,


};
pub const Event = struct {
    sdl_event:c.SDL_Event,

    pub fn init() Event {
        return .{.event = 0};
    }
    pub fn getType(self: *Event) u32 {
        return self.event.type;
    }
    pub fn poll(self: *Event) void {
        _ = c.SDL_PollEvent(&self.event);
    }
    pub fn getEvent() EventType {
        var event:c.SDL_Event = undefined;
        _ = c.SDL_PollEvent(&event);
        switch (event) {
            .type == c.SDL_MOUSEBUTTONDOWN => return EventType{
                
            }   
        }
    }
};

const MaterialType = union {
    solid:u8, //How hard it is to break it
    stringy:u8, //How tough is the string
    liquid:u8, //How viscous us the liquid
    powder:void, //None
    gas:void, //None
};
const FieldType = struct {
    id:u32,
    handlePhysics: * const fn(m:*Material) void,
};
const Material = struct {
    id: u32,
    name:[]const u8,
    color: col.Color,
    handlePhysics:*const fn(m:[9]*Material) void , //Middle element, or m[3] is the pixel itself.
    mat_type: MaterialType,
};

const std = @import("std");
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});

pub const Event = struct {
    event:c.SDL_Event,

    pub fn init() Event {
        return .{.event = 0};
    }
    pub fn getType(self: *Event) u32 {
        return self.event.type;
    }
    pub fn poll(self: *Event) void {
        _ = c.SDL_PollEvent(&self.event);
    }
};

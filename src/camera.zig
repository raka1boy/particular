const std = @import("std");
const Object = @import("object.zig").Object;
const coords = @import("coordinates.zig");
const Vec2 = coords.Vec2;
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});
pub const Camera = struct {
    obj:Object,
    zoom:i32,

    pub fn init(pos:Vec2) Camera {
        return .{.obj = Object.initWithPos(pos), .zoom = 0};
    }
    pub fn initAtZero() Camera {
        return .{.obj = Object.initWithPos(Vec2.init(0,0)), .zoom = 0};
    }
    pub fn getMousePos(self: *Camera) Vec2 {
        _ = self;
        var vect = Vec2.init(0,0);
        _ = c.SDL_GetMouseState(@ptrCast(&vect.pos[0]), @ptrCast(&vect.pos[1]));
        return vect;
    }

    pub fn getMousePos2(self: *Camera) Vec2 {
        //ГЛЕБ УЖЕ НЕ НАПИСАЛ   
        var vect = Vec2.init(0,0);
        _ = c.SDL_GetMouseState(@ptrCast(&vect.pos[0]), @ptrCast(&vect.pos[1]));
        return vect.add(self.obj.pos).negate();
        //return ray.getMousePosition().add(state.cam.pos.negate());
    }
};

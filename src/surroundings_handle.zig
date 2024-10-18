const std = @import("std");
const Object = @import("object.zig").Object;
const col = @import("color.zig");
const coords = @import("coordinates.zig");
const Vec2 = coords.Vec2;
const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3/SDL_vulkan.h");
});

const MaterialType = union {
    solid:u8, //How hard it is to break it
    stringy:u8, //How tough is the string
    liquid:u8, //How viscous us the liquid
    powder:void, //None
    gas:void, //None
}
const FieldType = struct {
    id: const u32,
    handlePhysics: const fn(m:*Material) void,
}
const Material = struct {
    id:const u32,
    color:const col.Color,
    handlePhysics:const fn(m:[9]*Material) void , //Middle element, or m[3] is the pixel itself.
    mat_type: const MaterialType,
};
pub fn NewSurroundingsHandle(comptime materials:[]Material ) struct {
    comptime var materialsList = {};
    return struct {
        avaliable_materials = materials,
    };
};
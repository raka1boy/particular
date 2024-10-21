const particular = @import("root.zig");
const c = particular.c;
const std = particular.std;
pub const SDLErrors = error {
    SdlInitError,
    SdlInitWindowError,
    SdlInitRendererError,
};
//pub const eventHandlerFunc = *const fn (state: *GameHandler) !void; 
pub const GameHandler = struct{
    window: *c.SDL_Window,
    renderer: *c.SDL_Renderer,
    camera: particular.Camera = particular.Camera.initAtZero(),
    current_event: c.SDL_Event = undefined,
    running: bool = true,


    pub fn init(window_name:[]const u8, w_height:u16, w_width:u16) !GameHandler {
        if(!c.SDL_Init(c.SDL_INIT_VIDEO)) {
            c.SDL_LogError(c.SDL_LOG_CATEGORY_APPLICATION, "SDL_Init failed: %s", c.SDL_GetError());
            return SDLErrors.SdlInitError;
        }
        const window = c.SDL_CreateWindow(@ptrCast(window_name), 
        w_width, w_height, 
        c.SDL_WINDOW_VULKAN) orelse {
            c.SDL_LogError(c.SDL_LOG_CATEGORY_APPLICATION, "SDL_CreateWindow failed: %s", c.SDL_GetError());
            c.SDL_Quit();
            return SDLErrors.SdlInitWindowError;
        };
        const renderer = c.SDL_CreateRenderer(window,null) orelse {
            c.SDL_LogError(c.SDL_LOG_CATEGORY_APPLICATION, "SDL_CreateRenderer failed: %s", c.SDL_GetError());
            c.SDL_Quit();
            return SDLErrors.SdlInitRendererError;
        };
        return .{.window = window, .renderer = renderer};
    }

    pub fn update(self: *GameHandler) void {
        _ = c.SDL_PollEvent(&self.current_event);
        if(self.current_event.type == c.SDL_EVENT_QUIT) {self.deinit(); self.running = false;}
    }

    pub fn deinit(self: *GameHandler) void {
        c.SDL_DestroyWindow(self.window);
        c.SDL_Quit();
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
    color: particular.color.Color,
    handlePhysics:*const fn(m:[9]*Material) void , //Middle element, or m[3] is the pixel itself.
    mat_type: MaterialType,
};

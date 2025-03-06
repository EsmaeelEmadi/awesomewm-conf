local naughty = require("naughty")
local gears = require("gears")
local colors = require("themes.mine.colors")

naughty.config.presets = { 
    normal = { 
        timeout = 5,
        bg = colors.color0,      
        fg = colors.foreground,       
        border_width = 2,
        border_color = colors.color8,
        font = naughty.config.font
    },
    low = { 
        timeout = 2,
        shape = gears.shape.rounded_rect,
        font = naughty.config.font
    }, 
    critical = { 
        timeout = 10,
        bg = colors.color1,     
        fg = colors.foreground,      
        border_width = 2,
        border_color = colors.color9,
        font = naughty.config.font 
    } 
}

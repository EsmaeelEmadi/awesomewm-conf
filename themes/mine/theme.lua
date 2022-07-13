local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

-- widgets
local batteryarc_widget = require(
                              "awesome-wm-widgets.batteryarc-widget.batteryarc")

--  local brightness_widget = require(
--                                "awesome-wm-widgets.brightness-widget.brightness")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
-- local logout_menu_widget = require(
--                                "awesome-wm-widgets.logout-menu-widget.logout-menu")
-- local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

local awesome, client, os = awesome, client, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local markup = lain.util.markup

local _bgColor = "#ffffff"
local _fgColor = "#ffffff"
local _mdColor = "#616161"
local _ldColor = "#000000"

local theme = {}
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/mine"

local naughty = require("naughty")
local beautiful = require("beautiful")

-- naughty.config.ontop = true
-- naughty.config.font = 'space mono 12'
-- naughty.config.icon_size = 10
-- beautiful.notification_font = 'space mono 12'
-- beautiful.notification_icon_size = 10
naughty.config.defaults['icon_size'] = 50

-- -- Default variables
theme.font = 'space mono 12'

theme.border_focus = '#928374'
theme.border_normal = '#282828'
-- theme.border_width = dpi(0.5)

-- -- taglist

theme.taglist_fg_focus = "#b16286"
theme.taglist_bg_focus = '#00000000'
theme.taglist_bg_occupied = '#00000000'
theme.taglist_fg_occupied = '#a89984'
theme.taglist_bg_empty = nil
theme.taglist_fg_empty = nil
theme.taglist_font = "SFMono"

-- -- tasklist
theme.tasklist_fg_normal = "#ffffff"
theme.tasklist_bg_normal = "#000000"
theme.tasklist_fg_focus = _fgColor
theme.tasklist_bg_focus = _bgColor
theme.tasklist_fg_minimize = "#616161"

-- -- useless
theme.useless_gap = dpi(0)
-- theme.useless_gap = nil

-- -- wibar
theme.wibar_stretch = true
theme.wibar_border_width = dpi(3)
theme.wibar_bg = _bgColor

-- -- -- -- icons
theme.vol = theme.dir .. "/icons/volume-high.png"
theme.vol_low = theme.dir .. "/icons/volume-low.png"
theme.vol_meduim = theme.dir .. "/icons/volume-meduim.png"
theme.vol_no = theme.dir .. "/icons/volume-muted.png"
theme.vol_mute = theme.dir .. "/icons/volume-muted-blocked.png"
theme.dot = theme.dir .. "/icons/dot.png"
-- clock
local markup = lain.util.markup
-- local blue   = "#80CCE6"
local space3 = markup.font("SFMono 3", "")

local mytextclock = wibox.widget.textclock(
                        markup("#a89984", space3 .. "%H:%M   " ..
                                   markup.font("SFMono 3", " ")))
mytextclock.font = theme.font
-- local mytextclock = wibox.widget.textclock("<span> </span>%H:%M ")
-- mytextclock.font = theme.font

-- volume
local volicon = wibox.widget.imagebox(theme.vol)
theme.volume = lain.widget.alsabar {
    width = dpi(60),
    border_width = 0,
    ticks = true,
    ticks_size = dpi(6),
    notification_preset = {font = theme.font},
    -- togglechannel = "IEC958,3",
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.vol_mute)
        elseif volume_now.level == 0 then
            volicon:set_image(theme.vol_no)
        elseif volume_now.level >= 85 then
            volicon:set_image(theme.vol)
        elseif volume_now.level >= 55 then
            volicon:set_image(theme.vol_meduim)
        elseif volume_now.level >= 25 then
            volicon:set_image(theme.vol_low)
            -- else
            --     volicon:set_image(theme.vol)
        end
    end,
    colors = {background = green, mute = red, unmute = green}
}
-- theme.volume.tooltip.wibox.bg = _bgColor
theme.volume.bar:buttons(my_table.join(awful.button({}, 1, function()
    awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
end), awful.button({}, 2, function()
    os.execute(string.format("%s set %s 100%%", theme.volume.cmd,
                             theme.volume.channel))
    theme.volume.update()
end), awful.button({}, 3, function()
    os.execute(string.format("%s set %s toggle", theme.volume.cmd,
                             theme.volume.togglechannel or theme.volume.channel))
    theme.volume.update()
end), awful.button({}, 4, function()
    os.execute(string.format("%s set %s 1%%+", theme.volume.cmd,
                             theme.volume.channel))
    theme.volume.update()
end), awful.button({}, 5, function()
    os.execute(string.format("%s set %s 1%%-", theme.volume.cmd,
                             theme.volume.channel))
    theme.volume.update()
end)))
local volumebg = wibox.container.background(theme.volume.bar, nil,
                                            gears.shape.rectangle)
local volumewidget = wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(6),
                                            dpi(6))

-- Separators
local first = wibox.widget.textbox(markup.font("Dank Mono 3", " "))
local spr = wibox.widget.textbox(' ')
local small_spr = wibox.widget.textbox(markup.font("Dank Mono 4", " "))
local bar_spr = wibox.widget.textbox(markup.font("Dank Mono 3", " ") ..
                                         markup.fontfg(theme.font, _fgColor, "/") ..
                                         markup.font("Dank Mono 5", " "))

-- Eminent-like task filtering
local orig_filter = awful.widget.taglist.filter.all

-- Taglist label functions
awful.widget.taglist.filter.all = function(t, args)
    if t.selected or #t:clients() > 0 then return orig_filter(t, args) end
end

-- -- 
function theme.at_screen_connect(s)
    s.systray = wibox.widget.systray()
    s.systray.visible = false

    -- Quake application
    s.quake = lain.util.quake({app = awful.util.terminal})

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt({prompt = " Run : ", bg = "#000000"})
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(awful.button({}, 1, function()
        awful.layout.inc(1)
    end), awful.button({}, 2,
                       function() awful.layout.set(awful.layout.layouts[1]) end),
                                        awful.button({}, 3, function()
        awful.layout.inc(-1)
    end), awful.button({}, 4, function() awful.layout.inc(1) end), awful.button(
                                            {}, 5,
                                            function()
            awful.layout.inc(-1)
        end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all,
                                       awful.util.taglist_buttons)

    -- Create a tasklist widget
    -- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 5,
            shape_border_color = _fgColor
            -- shape = gears.shape.partially_rounded_rect
        },
        layout = {
            -- spacing = 3,
            spacing_widget = {
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place
            },
            -- spacing = 1,
            layout = wibox.layout.flex.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {id = 'icon_role', widget = wibox.widget.imagebox},
                        margins = 0,
                        widget = wibox.container.margin
                    },
                    {id = 'text_role', widget = wibox.widget.textbox},
                    layout = wibox.layout.fixed.horizontal
                },
                left = 7,
                right = 7,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        }
    }

    s.mywibox = awful.wibar({
        position = "bottom",
        screen = s,
        height = dpi(30),
        border_width = dpi(0),
        -- bg = '#282828',
        bg = '#000000',
        fg = '#ffffff'
    })

    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            -- lspace1,
            wibox.widget.textbox('   '),
            s.mytaglist,
            wibox.widget.textbox('   '),
            s.mypromptbox,
            wibox.widget.textbox('   ')
            -- lspace2,
            -- s.layoutb,
            -- wibox.container.margin(mylauncher, dpi(5), dpi(8), dpi(13), dpi(0))
        },
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            -- brightness_widget({color = '#434c5e'}),

            cpu_widget({color = '#689d6a', width = 50}),
            -- logout_menu_widget({color = '#434c5e'}),
            -- volume_widget({type='arc'}),
            wibox.widget.textbox('   '),
            batteryarc_widget({
                arc_thickness = 2,
                size = 14,
                color = '#cc241d',
                main_color = '#fabd2f'
            }),
            wibox.widget.textbox('   ')

            -- wibox.widget.textbox('   '),
            -- kbdcfg.widget
        }
    }

end

return theme

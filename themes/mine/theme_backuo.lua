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

local _bgColor = "#eeeeee00"
local _fgColor = "#ffffff"
local _mdColor = "#616161"
local _ldColor = "#000000"

local theme = {}
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/mine"

local naughty = require("naughty")

-- -- Default variables
theme.font = 'space mono 12'
-- theme.wallpaper = '/home/emad/Pictures/antelope-canyon-3840x2160-arizona-usa-4k-16283.jpeg'


-- -- arcchart
-- theme.arcchart_border_color = nil
-- theme.arcchart_color = nil
-- theme.arcchart_border_width = nil
-- theme.arcchart_paddings = nil
-- theme.arcchart_thickness = nil

-- -- awesome
-- theme.awesome_icon = nil

-- -- bg
-- theme.bg_normal = nil
-- theme.bg_normal = nil
-- theme.bg_normal = nil
-- theme.bg_focus = nil
-- theme.bg_urgent = nil
-- theme.bg_minimize = nil
-- theme.bg_systray = nil
-- theme.bg_normal = nil
-- theme.bg_systray = nil

-- -- border
-- theme.border_marked = nil
-- theme.border_width = nil
-- theme.border_normal = nil
-- theme.border_focus = nil
-- theme.border_marked = nil
theme.border_focus = '#ffffff'
theme.border_normal = '#000000'
theme.border_width = dpi(0)

-- -- calendar
-- theme.calendar_style = nil
-- theme.calendar_font = nil
-- theme.calendar_spacing = nil
-- theme.calendar_week_numbers = nil
-- theme.calendar_start_sunday = nil
-- theme.calendar_long_weekdays = nil

-- -- checkbox
-- theme.checkbox_border_width = nil
-- theme.checkbox_bg = nil
-- theme.checkbox_border_color = nil
-- theme.checkbox_check_border_color = nil
-- theme.checkbox_check_border_width = nil
-- theme.checkbox_check_color = nil
-- theme.checkbox_shape = nil
-- theme.checkbox_check_shape = nil
-- theme.checkbox_paddings = nil
-- theme.checkbox_color = nil

-- -- column
-- theme.column_count = nil

-- -- cursor
-- theme.cursor_mouse_resize = nil
-- theme.cursor_mouse_move = nil

-- -- enable
-- theme.enable_spawn_cursor = nil

-- -- fg
-- theme.fg_normal = nil
-- theme.fg_normal = nil
-- theme.fg_normal = nil
-- theme.fg_focus = nil
-- theme.fg_urgent = nil
-- theme.fg_minimize = nil
-- theme.fg_normal = nil

-- -- fullscreen
-- theme.fullscreen_hide_border = nil

-- -- gap
-- theme.gap_single_client = nil

-- -- graph
-- theme.graph_bg = nil
-- theme.graph_fg = nil
-- theme.graph_border_color = nil

-- -- hotkeys
-- theme.hotkeys_bg = nil
-- theme.hotkeys_fg = nil
-- theme.hotkeys_border_width = nil
-- theme.hotkeys_border_color = nil
-- theme.hotkeys_shape = nil
-- theme.hotkeys_modifiers_fg = nil
-- theme.hotkeys_label_bg = nil
-- theme.hotkeys_label_fg = nil
-- theme.hotkeys_font = nil
-- theme.hotkeys_description_font = nil
-- theme.hotkeys_group_margin = nil

-- -- icon
-- theme.icon_theme = nil

-- -- layout
-- theme.layout_cornernw = nil
-- theme.layout_cornerne = nil
-- theme.layout_cornersw = nil
-- theme.layout_cornerse = nil
-- theme.layout_fairh = nil
-- theme.layout_fairv = nil
-- theme.layout_floating = nil
-- theme.layout_magnifier = nil
-- theme.layout_max = nil
-- theme.layout_fullscreen = nil
-- theme.layout_spiral = nil
-- theme.layout_dwindle = nil
-- theme.layout_tile = nil
-- theme.layout_tiletop = nil
-- theme.layout_tilebottom = nil
-- theme.layout_tileleft = nil

-- -- layoutlist
-- theme.layoutlist_fg_normal = nil
-- theme.layoutlist_bg_normal = nil
-- theme.layoutlist_fg_selected = nil
-- theme.layoutlist_bg_selected = nil
-- theme.layoutlist_disable_icon = nil
-- theme.layoutlist_disable_name = nil
-- theme.layoutlist_font = nil
-- theme.layoutlist_align = nil
-- theme.layoutlist_font_selected = nil
-- theme.layoutlist_spacing = nil
-- theme.layoutlist_shape = nil
-- theme.layoutlist_shape_border_width = nil
-- theme.layoutlist_shape_border_color = nil
-- theme.layoutlist_shape_selected = nil
-- theme.layoutlist_shape_border_width_selected = nil
-- theme.layoutlist_shape_border_color_selected = nil

-- -- master
-- theme.master_width_factor = nil
-- theme.master_fill_policy = nil
-- theme.master_count = nil

-- -- maximized
-- theme.maximized_honor_padding = nil
-- theme.maximized_hide_border = nil

-- -- menu
-- theme.menu_submenu_icon = nil
-- theme.menu_font = nil
-- theme.menu_height = nil
-- theme.menu_width = nil
-- theme.menu_border_color = nil
-- theme.menu_border_width = nil
-- theme.menu_fg_focus = nil
-- theme.menu_bg_focus = nil
-- theme.menu_fg_normal = nil
-- theme.menu_bg_normal = nil
-- theme.menu_submenu = nil

-- -- menubar
-- theme.menubar_fg_normal = nil
-- theme.menubar_bg_normal = nil
-- theme.menubar_border_width = nil
-- theme.menubar_border_color = nil
-- theme.menubar_fg_normal = nil
-- theme.menubar_bg_normal = nil

-- -- notification
-- theme.notification_font = nil
-- theme.notification_bg = nil
-- theme.notification_fg = nil
-- theme.notification_border_width = nil
-- theme.notification_border_color = nil
-- theme.notification_shape = nil
-- theme.notification_opacity = nil
-- theme.notification_margin = nil
-- theme.notification_width = nil
-- theme.notification_height = nil
-- theme.notification_max_width = nil
-- theme.notification_max_height = nil
-- theme.notification_icon_size = nil

-- -- piechart
-- theme.piechart_border_color = nil
-- theme.piechart_border_width = nil
-- theme.piechart_colors = nil

-- -- progressbar
-- theme.progressbar_bg = nil
-- theme.progressbar_fg = nil
-- theme.progressbar_shape = nil
-- theme.progressbar_border_color = nil
-- theme.progressbar_border_width = nil
-- theme.progressbar_bar_shape = nil
-- theme.progressbar_bar_border_width = nil
-- theme.progressbar_bar_border_color = nil
-- theme.progressbar_margins = nil
-- theme.progressbar_paddings = nil

-- -- prompt
-- theme.prompt_fg_cursor = nil
-- theme.prompt_bg_cursor = nil
-- theme.prompt_font = nil
-- theme.prompt_fg = nil
-- theme.prompt_bg = nil

-- -- radialprogressbar
-- theme.radialprogressbar_border_color = nil
-- theme.radialprogressbar_color = nil
-- theme.radialprogressbar_border_width = nil
-- theme.radialprogressbar_paddings = nil

-- -- separator
-- theme.separator_thickness = nil
-- theme.separator_border_color = nil
-- theme.separator_border_width = nil
-- theme.separator_span_ratio = nil
-- theme.separator_color = nil
-- theme.separator_shape = nil

-- -- slider
-- theme.slider_bar_border_width = nil
-- theme.slider_bar_border_color = nil
-- theme.slider_handle_border_color = nil
-- theme.slider_handle_border_width = nil
-- theme.slider_handle_width = nil
-- theme.slider_handle_color = nil
-- theme.slider_handle_shape = nil
-- theme.slider_bar_shape = nil
-- theme.slider_bar_height = nil
-- theme.slider_bar_margins = nil
-- theme.slider_handle_margins = nil
-- theme.slider_bar_color = nil

-- -- snap
-- theme.snap_bg = nil
-- theme.snap_border_width = nil
-- theme.snap_shape = nil

-- -- snapper
-- theme.snapper_gap = nil

-- -- systray
-- theme.systray_icon_spacing = nil

-- -- taglist

theme.taglist_fg_focus = "#000000ad"
theme.taglist_bg_focus = '#ffffffad'
-- theme.taglist_fg_urgent = ni
-- theme.taglist_bg_urgent = nil
theme.taglist_bg_occupied = '#f1f3f400'
theme.taglist_fg_occupied = '#ffffffad'
-- theme.taglist_bg_empty = nil
-- theme.taglist_fg_empty = nil
-- theme.taglist_bg_volatile = nil
-- theme.taglist_fg_volatile = nil
-- theme.taglist_squares_sel = nil
-- theme.taglist_squares_unsel = nil
-- theme.taglist_squares_sel_empty = nil
-- theme.taglist_squares_unsel_empty = nil
-- theme.taglist_squares_resize = nil
-- theme.taglist_disable_icon = nil
-- theme.taglist_font = nil
-- theme.taglist_spacing = nil
-- theme.taglist_shape = nil
-- theme.taglist_shape_border_width = nil
-- theme.taglist_shape_border_color = nil
-- theme.taglist_shape_empty = nil
-- theme.taglist_shape_border_width_empty = nil
-- theme.taglist_shape_border_color_empty = nil
-- theme.taglist_shape_focus = nil
-- theme.taglist_shape_border_width_focus = nil
-- theme.taglist_shape_border_color_focus = nil
-- theme.taglist_shape_urgent = nil
-- theme.taglist_shape_border_width_urgent = nil
-- theme.taglist_shape_border_color_urgent = nil
-- theme.taglist_shape_volatile = nil
-- theme.taglist_shape_border_width_volatile = nil
-- theme.taglist_shape_border_color_volatile = nil

-- -- tasklist
theme.tasklist_fg_normal = "#bdbdbd"
theme.tasklist_bg_normal = _bgColor
theme.tasklist_fg_focus = _fgColor
theme.tasklist_bg_focus = _bgColor
-- theme.tasklist_fg_urgent = nil
-- theme.tasklist_bg_urgent = nil
theme.tasklist_fg_minimize = "#616161"
-- theme.tasklist_bg_minimize = nil
-- theme.tasklist_bg_image_normal = nil
-- theme.tasklist_bg_image_focus = nil
-- theme.tasklist_bg_image_urgent = nil
-- theme.tasklist_bg_image_minimize = nil
-- theme.tasklist_disable_icon = nil
-- theme.tasklist_disable_task_name = true
-- theme.tasklist_plain_task_name = true
-- theme.tasklist_font = nil
-- theme.tasklist_align = 'center'
-- theme.tasklist_font_focus = nil
-- theme.tasklist_font_minimized = nil
-- theme.tasklist_font_urgent = nil
-- theme.tasklist_spacing = 10
-- theme.tasklist_shape = gears.shape.rounded_rect
-- theme.tasklist_shape_border_width = nil
-- theme.tasklist_shape_border_color = nil
-- theme.tasklist_shape_focus = nil
-- theme.tasklist_shape_border_width_focus = dpi(2)
-- theme.tasklist_shape_border_color_focus = nil
-- theme.tasklist_shape_minimized = nil
-- theme.tasklist_shape_border_width_minimized = nil
-- theme.tasklist_shape_border_color_minimized = nil
-- theme.tasklist_shape_urgent = nil
-- theme.tasklist_shape_border_width_urgent = nil
-- theme.tasklist_shape_border_color_urgent = nil

-- -- titlebar
-- theme.titlebar_fg_normal = nil
-- theme.titlebar_bg_normal = nil
-- theme.titlebar_bgimage_normal = nil
-- theme.titlebar_fg = nil
-- theme.titlebar_bg = nil
-- theme.titlebar_bgimage = nil
-- theme.titlebar_fg_focus = nil
-- theme.titlebar_bg_focus = nil
-- theme.titlebar_bgimage_focus = nil
-- theme.titlebar_floating_button_normal = nil
-- theme.titlebar_maximized_button_normal = nil
-- theme.titlebar_minimize_button_normal = nil
-- theme.titlebar_minimize_button_normal_hover = nil
-- theme.titlebar_minimize_button_normal_press = nil
-- theme.titlebar_close_button_normal = nil
-- theme.titlebar_close_button_normal_hover = nil
-- theme.titlebar_close_button_normal_press = nil
-- theme.titlebar_ontop_button_normal = nil
-- theme.titlebar_sticky_button_normal = nil
-- theme.titlebar_floating_button_focus = nil
-- theme.titlebar_maximized_button_focus = nil
-- theme.titlebar_minimize_button_focus = nil
-- theme.titlebar_minimize_button_focus_hover = nil
-- theme.titlebar_minimize_button_focus_press = nil
-- theme.titlebar_close_button_focus = nil
-- theme.titlebar_close_button_focus_hover = nil
-- theme.titlebar_close_button_focus_press = nil
-- theme.titlebar_ontop_button_focus = nil
-- theme.titlebar_sticky_button_focus = nil
-- theme.titlebar_floating_button_normal_active = nil
-- theme.titlebar_floating_button_normal_active_hover = nil
-- theme.titlebar_floating_button_normal_active_press = nil
-- theme.titlebar_maximized_button_normal_active = nil
-- theme.titlebar_maximized_button_normal_active_hover = nil
-- theme.titlebar_maximized_button_normal_active_press = nil
-- theme.titlebar_ontop_button_normal_active = nil
-- theme.titlebar_ontop_button_normal_active_hover = nil
-- theme.titlebar_ontop_button_normal_active_press = nil
-- theme.titlebar_sticky_button_normal_active = nil
-- theme.titlebar_sticky_button_normal_active_hover = nil
-- theme.titlebar_sticky_button_normal_active_press = nil
-- theme.titlebar_floating_button_focus_active = nil
-- theme.titlebar_floating_button_focus_active_hover = nil
-- theme.titlebar_floating_button_focus_active_press = nil
-- theme.titlebar_maximized_button_focus_active = nil
-- theme.titlebar_maximized_button_focus_active_hover = nil
-- theme.titlebar_maximized_button_focus_active_press = nil
-- theme.titlebar_ontop_button_focus_active = nil
-- theme.titlebar_ontop_button_focus_active_hover = nil
-- theme.titlebar_ontop_button_focus_active_press = nil
-- theme.titlebar_sticky_button_focus_active = nil
-- theme.titlebar_sticky_button_focus_active_hover = nil
-- theme.titlebar_sticky_button_focus_active_press = nil
-- theme.titlebar_floating_button_normal_inactive = nil
-- theme.titlebar_floating_button_normal_inactive_hover = nil
-- theme.titlebar_floating_button_normal_inactive_press = nil
-- theme.titlebar_maximized_button_normal_inactive = nil
-- theme.titlebar_maximized_button_normal_inactive_hover = nil
-- theme.titlebar_maximized_button_normal_inactive_press = nil
-- theme.titlebar_ontop_button_normal_inactive = nil
-- theme.titlebar_ontop_button_normal_inactive_hover = nil
-- theme.titlebar_ontop_button_normal_inactive_press = nil
-- theme.titlebar_sticky_button_normal_inactive = nil
-- theme.titlebar_sticky_button_normal_inactive_hover = nil
-- theme.titlebar_sticky_button_normal_inactive_press = nil
-- theme.titlebar_floating_button_focus_inactive = nil
-- theme.titlebar_floating_button_focus_inactive_hover = nil
-- theme.titlebar_floating_button_focus_inactive_press = nil
-- theme.titlebar_maximized_button_focus_inactive = nil
-- theme.titlebar_maximized_button_focus_inactive_hover = nil
-- theme.titlebar_maximized_button_focus_inactive_press = nil
-- theme.titlebar_ontop_button_focus_inactive = nil
-- theme.titlebar_ontop_button_focus_inactive_hover = nil
-- theme.titlebar_ontop_button_focus_inactive_press = nil
-- theme.titlebar_sticky_button_focus_inactive = nil
-- theme.titlebar_sticky_button_focus_inactive_hover = nil
-- theme.titlebar_sticky_button_focus_inactive_press = nil

-- -- tooltip
-- theme.tooltip_border_color = nil
-- theme.tooltip_bg = nil
-- theme.tooltip_fg = nil
-- theme.tooltip_font = nil
-- theme.tooltip_border_width = nil
-- theme.tooltip_opacity = nil
-- theme.tooltip_shape = nil
-- theme.tooltip_align = nil

-- -- useless
theme.useless_gap = dpi(0)
-- theme.useless_gap = nil

-- -- wibar
theme.wibar_stretch = true
theme.wibar_border_width = dpi(3)
-- theme.wibar_border_color = _bgColor
-- theme.wibar_ontop = true
-- theme.wibar_cursor = nil
-- theme.wibar_opacity = nil
-- theme.wibar_type = 'desktop'
-- theme.wibar_width = nil
-- theme.wibar_height = dpi(200)
theme.wibar_bg = _bgColor
-- theme.wibar_bgimage = nil
-- theme.wibar_fg = nil
-- theme.wibar_shape = nil

-- -- -- -- icons
theme.vol = theme.dir .. "/icons/volume-high.png"
theme.vol_low = theme.dir .. "/icons/volume-low.png"
theme.vol_meduim = theme.dir .. "/icons/volume-meduim.png"
theme.vol_no = theme.dir .. "/icons/volume-muted.png"
theme.vol_mute = theme.dir .. "/icons/volume-muted-blocked.png"

-- clock
local markup = lain.util.markup
-- local blue   = "#80CCE6"
local space3 = markup.font("Roboto 3", "")
local mytextclock = wibox.widget.textclock(markup("#FFFFFFad", space3 .. "%H:%M   " .. markup.font("Roboto 4", " ")))
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
    s.mypromptbox = awful.widget.prompt({prompt = " Run : ", bg = "#e0e0e0"})
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
                -- {
                --     forced_width = 5,
                --     forced_height = 24,
                --     thickness = 1,
                --     color = '#777777',
                --     widget = wibox.widget.separator
                -- },
                -- {
                --     forced_width = 5,
                --     shape = gears.shape.circle,
                --     widget = wibox.widget.separator
                -- },
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

    local kbdcfg = {}
    kbdcfg.widget = wibox.widget.textbox()
    kbdcfg.switch = function()
        current_kb = io.popen("xkb-switch -p -n"):read("*a")
        kbdcfg.widget:set_text(current_kb)
    end
    kbdcfg.switch()

    -- Create the wibox
    -- s.mywibox = awful.wibar({
    --     position = "top",
    --     screen = s,
    --     height = dpi(20),
    --     bg = _bgColor,
    --     fg = _fgColor
    -- })

    -- s.wwibox = awful.wibar({
    --     ontop = true,
    --     type = "desktop",
    --     -- visible = false,
    --     -- x = 0,
    --     -- y = 0,
    --     -- stretch = false,
    --     -- position = nil,
    --     screen = s,
    --     height = dpi(20),
    --     bg = _bgColor,
    --     fg = _fgColor
    -- })

    -- s.wwibox.visible = false
    -- theme.wibar_ontop = false

    -- s.wwibox.ontop = false

    -- Add widgets to the wibox
    -- s.mywibox:setup{

    --     layout = wibox.layout.align.horizontal,
    --     { -- Left widgets
    --         layout = wibox.layout.fixed.horizontal,
    --         -- small_spr,
    --         first,
    --         s.mytaglist,
    --         bar_spr,
    --         s.mypromptbox,
    --         -- bar_spr,
    --         s.mytasklist,
    --         -- bar_spr,
    --         first
    --         -- s.systray
    --     },
    --     -- s.mytasklist, -- Middle widget
    --     nil,
    --     { -- Right widgets
    --         layout = wibox.layout.fixed.horizontal,
    --         bar_spr,
    --         volicon,
    --         volumewidget,
    --         bar_spr,
    --         awful.widget.keyboardlayout:new(),
    --         bar_spr,
    --         mytextclock

    --     }
    -- }

    -- s.wwibox:setup{
    --     layout = wibox.layout.align.horizontal,
    --     nil,
    --     { -- Left widgets
    --         layout = wibox.layout.fixed.horizontal,
    --         -- small_spr,
    --         -- first,
    --         s.mytaglist,
    --         -- bar_spr,
    --         s.mypromptbox
    --         -- bar_spr,
    --         -- s.mytasklist,
    --         -- bar_spr,
    --         -- first
    --         -- s.systray
    --     },
    --     -- s.mytasklist, -- Middle widget

    --     nil
    -- }

    -- Add widgets to the vertical wibox

    -- function theme.vertical_wibox(s)

    -- naughty.notify({
    --     preset = naughty.config.presets.critical,
    --     title = "Oops, there were errors during startup!",
    --     text = s.geometry.x

    -- })

    -- s.wwibox = wibox({
    --     screen = s,
    --     width = s.workarea.width,
    --     height = dpi(40),
    --     stretch = false,
    --     -- x = s.workarea.width / 2,
    --     y = 0,
    --     bg = _bgColor,
    --     fg = _fgColor,
    --     ontop = true,
    --     visible = false,
    --     type = "desktop"
    -- })
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = dpi(25),
        -- border_width = dpi(5),
        bg = '#32302f00',
        fg = '#ffffffad'
    })
    -- if s.index > 1 and s.wwibox.y == 0 then
    --     s.wwibox.y = screen[1].wwibox.y
    -- end

    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            -- lspace1,
            wibox.widget.textbox('   '),
            s.mytaglist,
            wibox.widget.textbox('   '),
            s.mypromptbox,
            wibox.widget.textbox('   '),
            -- lspace2,
            -- s.layoutb,
            -- wibox.container.margin(mylauncher, dpi(5), dpi(8), dpi(13), dpi(0))
        },
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            -- brightness_widget({color = '#434c5e'}),

            cpu_widget({color = '#ffffffad'}),
            -- logout_menu_widget({color = '#434c5e'}),
            -- volume_widget({type='arc'}),
            wibox.widget.textbox('   '),
            batteryarc_widget({arc_thickness = 3, color = '#ffffffad'}),
            wibox.widget.textbox('   '),
            
            mytextclock,
            wibox.widget.textbox('   '),
        }
    }

    -- awful.screen.connect_for_each_screen(function(s)
    --     -- do something
    --     s.wwibox.x = s.workarea.x / 2
    -- end)
    -- for s in screen do
    --     -- do something
    --     s.wwibox.x = s.workarea.x / 2
    -- end

    -- end

    -- gears.timer.delayed_call(theme.vertical_wibox, s)

    -- Add toggling functionalities
    -- s.docktimer = gears.timer {
    --     timeout = 2
    -- }
    -- s.docktimer:connect_signal("timeout", function()
    --     local s = awful.screen.focused()
    --     s.myleftwibox.width = dpi(9)
    --     s.layoutb.visible = false
    --     mylauncher.visible = false
    --     if s.docktimer.started then
    --         s.docktimer:stop()
    --     end
    -- end)
    -- tag.connect_signal("property::selected", function(t)
    --     local s = t.screen or awful.screen.focused()
    --     s.myleftwibox.width = dpi(38)
    --     s.layoutb.visible = true
    --     mylauncher.visible = true
    --     gears.surface.apply_shape_bounding(s.myleftwibox, dockshape)
    --     if not s.docktimer.started then
    --         s.docktimer:start()
    --     end
    -- end)

    -- s.myleftwibox:connect_signal("mouse::leave", function()
    --     local s = awful.screen.focused()
    --     s.myleftwibox.width = dpi(9)
    --     s.layoutb.visible = false
    --     mylauncher.visible = false
    -- end)

    -- s.myleftwibox:connect_signal("mouse::enter", function()
    --     local s = awful.screen.focused()
    --     s.myleftwibox.width = dpi(38)
    --     s.layoutb.visible = true
    --     mylauncher.visible = true
    --     gears.surface.apply_shape_bounding(s.myleftwibox, dockshape)
    -- end)

end

return theme

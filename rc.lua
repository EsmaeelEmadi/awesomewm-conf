local lain = require("lain")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gears = require("gears")
local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi
local xrandr = require("utils.xrandr")


require("awful.autofocus")

require("startup.init")

local theme = require("themes.mine.theme")
local layout_stacked = require("layouts.stacked")
local layout_cascade = require("layouts.cascade")

local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local icon_size = 128                            -- Define your preferred icon size (width and height)

local function resize_icon(icon_name, size)
    local svg_path = "/usr/share/icons/WhiteSur/apps/scalable/" .. icon_name .. ".svg"
    local png_path = "/tmp/" .. icon_name .. icon_size .. ".png"
    local command = "convert -background none -resize " .. size .. "x" .. size .. " " .. svg_path .. " " .. png_path

    if not gears.filesystem.file_readable(png_path) then
        os.execute(command)
    end

    return png_path
end

local app_icons = {
    Code = "visual-studio-code",
    kitty = "kitty",
    firefox = "firefox",
    ["Vivaldi-stable"] = "vivaldi",
    ["Google-chrome"] = "google-chrome",
    Nitrogen = "wallpaper",
    ghostty = "kitty"
    -- Add more applications and their respective icons as needed
}

-- keyboard layout
local layout_indicator = require("utils.keyboard-layout-indicator")
-- define your layouts
kbdcfg = layout_indicator({
    layouts = {
        { name = "fa", layout = "fa", variant = "qwerty" },
        { name = "us", layout = "us", variant = nil },
    },
    -- optionally, specify commands to be executed after changing layout:
    post_set_hooks = { "xmodmap ~/.Xmodmap", "setxkbmap -option caps:escape" },
})

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err),
        })
        in_error = false
    end)
end

-- run_once({ "urxvtd", "unclutter -root" }) -- entries must be separated by commas

-- local chosen_theme = "mine"
local modkey = "Mod4"
local altkey = "Mod1"
local terminal = "ghostty"
local vi_focus = false  -- vi-like client focus - https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev = true -- cycle trough all previous client or just the first -- https://github.com/lcpz/awesome-copycats/issues/274
local editor = os.getenv("EDITOR") or "vim"
local gui_editor = os.getenv("GUI_EDITOR") or "gedit"
local browser = os.getenv("BROWSER") or "google-chrome"
local scrlocker = "slock"

awful.util.terminal = terminal
awful.util.tagnames = { "1", "2", "3", "4", "5" }
awful.layout.layouts = { layout_cascade, layout_stacked, awful.layout.suit.tile }
-- awful.layout.suit.spiral
 
awful.util.taglist_buttons = my_table.join(
    awful.button({}, 5, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            -- c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({}, 2, function(c)
        c:kill()
    end),
    awful.button({}, 3, function()
        local instance = nil

        return function()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({ theme = { width = dpi(250) } })
            end
        end
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1
lain.layout.cascade.tile.offset_x = dpi(2)
lain.layout.cascade.tile.offset_y = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster = 5
lain.layout.cascade.tile.ncol = 2

beautiful.init(theme)
-- }}}

-- {{{ Menu
local myawesomemenu = {
    {
        "hotkeys",
        function()
            return false, hotkeys_popup.show_help
        end,
    },
    { "manual",  terminal .. " -e man awesome" },
    {
        "edit config",
        string.format("%s -e %s %s", terminal, editor, awesome.conffile),
    },
    { "restart", awesome.restart },
    {
        "quit",
        function()
            awesome.quit()
        end,
    },
}
-- awful.util.mymainmenu = freedesktop.menu.build({
--     icon_size = beautiful.menu_height or dpi(16),
--     before = {
--         { "Awesome", myawesomemenu, beautiful.awesome_icon },
--         -- other triads can be put here
--     },
--     after = {
--         { "Open terminal", terminal },
--         -- other triads can be put here
--     }
-- })
-- hide menu when mouse leaves it
-- awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

-- menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
-- screen.connect_signal("arrange", function(s)
--     local only_one = #s.tiled_clients == 1
--     for _, c in pairs(s.clients) do
--         if only_one and not c.floating or c.maximized then
--             c.border_width = 0
--         else
--             c.border_width = beautiful.border_width
--         end
--     end
-- end)

-- client.connect_signal("manage", function (c)
--     c.shape = function(cr,w,h)
--         gears.shape.rounded_rect(cr,w,h,10)
--     end
-- end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    beautiful.at_screen_connect(s)
end)
-- }}}
-- awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[1])

-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({}, 3, function()
        awful.util.mymainmenu:toggle()
    end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = my_table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, {
        description = "show help",
        group = "awesome",
    }),
    -- awful.key({ modkey }, "h", awful.tag.viewprev,
    --     { description = "view previous", group = "tag" }),
    -- awful.key({ modkey }, "l", awful.tag.viewnext,
    --     { description = "view next", group = "tag" }),
    awful.key({ modkey }, "k", function()
        awful.client.focus.byidx(1)
    end, { description = "select next pane", group = "tag" }),
    awful.key({ modkey }, "j", function()
        awful.client.focus.byidx(-1)
    end, { description = "select prev pane", group = "tag" }),
    -- awful.key({ modkey }, "j", function() awful.client.focus.byidy(-1) end,
    --     { description = "select prev pane vertical", group = "tag" }),
    -- awful.key({ modkey }, "k", function() awful.client.focus.byidy(1) end,
    --     { description = "select next pane vertical", group = "tag" }),
    awful.key({ modkey, "Control" }, "1", function()
        awful.spawn("betterlockscreen -l")
    end, { description = "lock screen", group = "awesome" }),
    awful.key({ modkey, "Control" }, "`", function()
        xrandr.xrandr()
    end, {
        description = "focus next by index",
        group = "client",
    }),
    awful.key({ modkey, "Control" }, "Right", function()
        awful.client.swap.byidx(1)
    end, {
        description = "swap with next client by index",
        group = "client",
    }),
    awful.key({ modkey, "Control" }, "Left", function()
        awful.client.swap.byidx(-1)
    end, {
        description = "swap with previous client by index",
        group = "client",
    }),
    awful.key({ modkey }, "`", function()
        awful.screen.focus_relative(1)
    end, { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey }, "b", function()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
        end
    end, { description = "toggle wibox", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "n", function()
        lain.util.add_tag()
    end, {
        description = "add new tag",
        group = "tag",
    }),
    awful.key({ modkey, "Shift" }, "r", function()
        lain.util.rename_tag()
    end, { description = "rename tag", group = "tag" }),
    awful.key({ modkey, "Shift" }, "[", function()
        lain.util.move_tag(-1)
    end, {
        description = "move tag to the left",
        group = "tag",
    }),
    awful.key({ modkey, "Shift" }, "]", function()
        lain.util.move_tag(1)
    end, { description = "move tag to the right", group = "tag" }),
    awful.key({ modkey, "Shift" }, "d", function()
        lain.util.delete_tag()
    end, {
        description = "delete tag",
        group = "tag",
    }),
    awful.key({ modkey }, "Return", function()
        awful.spawn(terminal)
    end, { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart, {
        description = "reload awesome",
        group = "awesome",
    }),
    -- awful.key({modkey}, "e", function() awful.spawn('alacritty --config-file /home/emad/.config/alacritty/alacritty_nvim.yml ') end,
    --           {description = "open a terminal", group = "launcher"}),
    --                        awful.key({modkey, "Control"}, "r", awesome.restart,
    --                                  {
    -- description = "reload awesome",
    -- group = "awesome"
    -- }),

    awful.key({ modkey, "Shift" }, "Right", function()
        awful.tag.incmwfact(0.05)
    end, {
        description = "increase master width factor",
        group = "layout",
    }),
    awful.key({ modkey, "Shift" }, "Left", function()
        awful.tag.incmwfact(-0.05)
    end, {
        description = "decrease master width factor",
        group = "layout",
    }),
    awful.key({ modkey, "Control" }, "=", function()
        awful.tag.incnmaster(1, nil, true)
    end, {
        description = "increase the number of master clients",
        group = "layout",
    }),
    awful.key({ modkey, "Control" }, "-", function()
        awful.tag.incnmaster(-1, nil, true)
    end, {
        description = "decrease the number of master clients",
        group = "layout",
    }),
    awful.key({ modkey }, "=", function()
        awful.tag.incncol(1, nil, true)
    end, {
        description = "increase the number of columns",
        group = "layout",
    }),
    awful.key({ modkey }, "-", function()
        awful.tag.incncol(-1, nil, true)
    end, {
        description = "decrease the number of columns",
        group = "layout",
    }),
    awful.key({ modkey }, "space", function()
        awful.layout.inc(1)
    end, { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function()
        awful.layout.inc(-1)
    end, {
        description = "select previous",
        group = "layout",
    }),
    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            client.focus = c
            c:raise()
        end
    end, { description = "restore minimized", group = "client" }),
    awful.key({ modkey, "Shift" }, "0", function()
        awful.spawn.with_shell("glava --desktop --entry=me.glsl --force-mod=bars")
    end, { description = "GLava", group = "FUN" }),
    awful.key({ modkey }, "0", function()
        awful.spawn.with_shell("pkill glava")
    end, { description = "GLava", group = "FUN" }),
    awful.key({ modkey }, "r", function()
        awful.spawn.with_shell("rofi -show drun")
    end, { description = "GLava", group = "FUN" }),
    awful.key({ modkey }, "e", function()
        awful.spawn.with_shell("rofi -show windowcd")
    end, { description = "GLava", group = "FUN" }),
    awful.key({ modkey }, "a", function()
        awful.spawn.with_shell("rofi -show filebrowser")
    end, { description = "rofi windows", group = "launcher" }),
    awful.key({ modkey }, "w", function()
        awful.spawn.with_shell("rofi -show")
    end, { description = "rofi", group = "launcher" }),
    awful.key({ modkey }, "x", function()
        awful.prompt.run({
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval",
        })
    end, { description = "lua execute prompt", group = "awesome" }),
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
    end, { description = "amixer set master +", group = "awesome" }),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
    end, { description = "volume toggle", group = "awesome" }),
    awful.key({}, "XF86AudioMute", function()
        awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    end, { description = "Brightness +", group = "awesome" }),
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.util.spawn("light -A 10")
    end, { description = "Brightness -", group = "awesome" }),
    awful.key({}, "XF86MonBrightnessDown", function()
        awful.util.spawn("light -U 10")

        awful.spawn.easy_async_with_shell("setxkbmap -v | awk -F '+' '/symbols/ {print $2}'", function(stdout)
            -- naughty.notify({
            --     title = "Achtung!",
            --     text = stdout,
            --     timeout = 1
            -- })

            stdout = stdout:gsub("%s+", "")
            stdout = string.gsub(stdout, "%s+", "")

            if stdout == "us" then
                awful.spawn.with_shell("setxkbmap -layout ir")
            else
                awful.spawn.with_shell("setxkbmap -layout us")
            end
        end)
        -- if res == "layout: us" then
        -- awful.spawn.with_shell("setxkbmap -layout ir")
        -- end
        -- if res == "ir" then
        --     awful.spawn.with_shell("setxkbmap -layout us")
        -- end
    end, { description = "changing keyboard layout", group = "tag" })
)

-- awful.key({modkey}, "1", function()
--     awful.spawn.with_shell("alacritty -e vis")
--     awful.spawn.with_shell("alacritty -e ranger")
-- end, {
--     description = "music",
--     group = "fun"
-- }),
clientkeys = my_table.join(
    awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client, {
        description = "magnify client",
        group = "client",
    }),
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c)
        c:kill()
    end, { description = "close", group = "client" }),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, {
        description = "toggle floating",
        group = "client",
    }),
    awful.key({ modkey, "Control" }, "Return", function(c)
        c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),
    awful.key({ modkey }, "o", function(c)
        c:move_to_screen()
    end, {
        description = "move to screen",
        group = "client",
    }),
    awful.key({ modkey }, "t", function(c)
        c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey }, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, { description = "minimize", group = "client" }),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = "maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = { description = "view tag #", group = "tag" }
        descr_toggle = { description = "toggle tag #", group = "tag" }
        descr_move = {
            description = "move focused client to tag #",
            group = "tag",
        }
        descr_toggle_focus = {
            description = "toggle focused client on tag #",
            group = "tag",
        }
    end
    globalkeys = my_table.join(
        globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, descr_view),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, descr_toggle),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end, descr_move),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).

-- local function set_icon(class_name)
-- 	local icon_name = app_icons[class_name]
-- 	local svg_path = "/usr/share/icons/WhiteSur/apps/scalable/" .. icon_name .. ".svg"
-- 	local png_path = "/tmp/" .. icon_name .. icon_size .. ".png"
--
-- 	local command = "convert -background none -resize "
-- 		.. icon_size
-- 		.. "x"
-- 		.. icon_size
-- 		.. " "
-- 		.. svg_path
-- 		.. " "
-- 		.. png_path
--
-- 	if not gears.filesystem.file_readable(png_path) then
-- 		os.execute(command)
-- 	end
--
-- 	local icon_path = resize_icon(icon_name, icon_size)
-- 	local icon_surface = gears.surface.load_uncached(icon_path)
-- 	icon_surface:finish()
-- 	return icon_surface._native
--
-- 	-- naughty.notify({ title = "Fun Fact!", text = "" .. class_name })
-- 	--
-- 	-- if icon_name then
-- 	-- 	local svg_path = "/usr/share/icons/WhiteSur/apps/scalable/" .. icon_name .. ".svg"
-- 	--
-- 	-- 	if svg_path and gears.filesystem.file_readable(svg_path) then
-- 	-- 		local icon_path = resize_icon(icon_name, icon_size)
-- 	-- 		local icon_surface = gears.surface.load_uncached(icon_path)
-- 	-- 		icon_surface:finish()
-- 	-- 		return icon_surface._native
-- 	-- 	else
-- 	-- 		naughty.notify({ title = "Fun Fact!", text = "not icon for " .. class_name })
-- 	-- 	end
-- 	-- else
-- 	-- 	naughty.notify({ title = "Fun Fact!", text = "not icon for " .. class_name })
-- 	-- end
--
-- 	-- local icon_path = "/usr/share/icons/WhiteSur/apps/scalable/" .. class_name:lower() .. ".svg"
-- 	-- if gears.filesystem.file_readable(icon_path) then
-- 	--    naughty.notify({ title = "Fun Fact!", text = "found the icon", timeout = 20 })
-- 	-- 	return gears.surface.load_uncached(icon_path)
-- 	-- else
-- 	--    naughty.notify({ title = "Fun Fact!", text = "Icon not found: " .. icon_path, timeout = 20 })
-- 	-- 	return nil
-- 	-- end
-- end

beautiful.icon_theme = "WhiteSur"

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            size_hints_honor = false,
        },
    },

    -- start of icons ->
    -- { rule = { class = "kitty" }, properties = { icon = set_icon("kitty") } },
    -- { rule = { class = "Code" }, properties = { icon = set_icon("Code") } },
    -- end of icons <-
    -- {
    -- 	rule_any = { type = { "dialog", "normal" } },
    -- 	properties = { titlebars_enabled = true },
    -- },
    -- {
    -- 	rule = { class = "Firefox" },
    -- 	properties = { screen = 1, tag = awful.util.tagnames[1] },
    -- },
    -- {
    -- 	rule = { class = "Gimp", role = "gimp-image-window" },
    -- 	properties = { maximized = true },
    -- },
}
-- Define your custom icon paths for specific applications

-- Set icons dynamically on client manage
client.connect_signal("connect", function(c)
    local icon_name = app_icons[c.class]

    if icon_name then
        local svg_path = "/usr/share/icons/WhiteSur/apps/scalable/" .. icon_name .. ".svg"

        if svg_path and gears.filesystem.file_readable(svg_path) then
            local icon_path = resize_icon(icon_name, icon_size)
            local icon_surface = gears.surface.load_uncached(icon_path)
            c.icon = icon_surface._native
            icon_surface:finish()
        else
            naughty.notify({ title = "Fun Fact!", text = "not icon for " .. c.class, timeout = 20 })
        end
    else
        naughty.notify({ title = "Fun Fact!", text = "not icon for " .. c.class, timeout = 20 })
    end
end)

client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- client.connect_signal("property::icon", function(c)
-- 	-- if c._icon_set or clients_with_custom_icons[c.window] then
-- 	-- 	return
-- 	-- end
--
-- 	if not c._icon_set or not clients_with_custom_icons[c.window] then
-- 		local icon_name = app_icons[c.class]
--
-- 		if icon_name then
-- 			local svg_path = "/usr/share/icons/WhiteSur/apps/scalable/" .. icon_name .. ".svg"
--
-- 			if svg_path and gears.filesystem.file_readable(svg_path) then
-- 				local icon_path = resize_icon(icon_name, icon_size)
-- 				local icon_surface = gears.surface.load_uncached(icon_path)
-- 				c.icon = icon_surface._native
-- 				icon_surface:finish()
-- 				clients_with_custom_icons[c.window] = true -- Mark this client as having a custom icon
-- 				c._icon_set = true
-- 			else
-- 				naughty.notify({ title = "Fun Fact!", text = "not icon for " .. c.class, timeout = 20 })
-- 			end
-- 		else
-- 			naughty.notify({ title = "Fun Fact!", text = "not icon for " .. c.class, timeout = 20 })
-- 		end
-- 	end
-- end)
-- local clients_with_custom_icons = {}

local function set_client_icon(c)
    -- local icon_set = false

    if not c.class then
        return c
    end

    local icon_name = app_icons[c.class]
    naughty.notify({ title = "Fun Fact!", text = c.class, timeout = 20 })

    if icon_name then
        local svg_path = "/usr/share/icons/WhiteSur/apps/scalable/" .. icon_name .. ".svg"

        if svg_path and gears.filesystem.file_readable(svg_path) then
            local icon_path = resize_icon(icon_name, icon_size)
            local icon_surface = gears.surface.load_uncached(icon_path)
            c.icon = icon_surface._native

            -- clients_with_custom_icons[c.class] = true
            icon_surface:finish()
        else
            naughty.notify({ title = "Fun Fact!", text = "not icon for " .. c.class, timeout = 20 })
        end
    else
        naughty.notify({ title = "Fun Fact!", text = "not icon for " .. c.class, timeout = 20 })
    end
end

local menubar_utils = require("menubar.utils")

client.connect_signal("property::class", function(c)
    -- set_client_icon(c)
    if not c.class then
        return
    end

    c.theme_icon = menubar_utils.lookup_icon(string.lower(c.class)) or c.icon
    awful.titlebar.widget.iconwidget(c)

    -- c:connect_signal("property::task", function(_c)
    -- 	set_client_icon(_c)
    -- end)
end)

-- client.connect_signal("property::icon", function(c)
-- 	naughty.notify({ title = "Fun Fact!", text = "icon " .. c.class, timeout = 3 })
-- 	-- if c.class then
-- 	-- 	if not clients_with_custom_icons[c.class] then
-- 	-- 		set_client_icon(c)
-- 	-- 	end
-- 	-- end
-- end)

client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = vi_focus })
end)

client.connect_signal("focus", function(c)
    if beautiful.border_focus then
        c.border_color = beautiful.border_focus
    end
end)
client.connect_signal("unfocus", function(c)
    if beautiful.border_normal then
        c.border_color = beautiful.border_normal
    end
end)

for key, value in pairs(theme.beautiful) do
    beautiful[key] = value
end

for key, value in pairs(theme.naughty) do
    naughty[key] = value
end

-- beautiful.size_hint_honor = true
-- beautiful.gap_single_client = true
beautiful.useless_gap = 5

naughty.notify({
    title = "hello",
    text = "dear sexy slaught",
    timeout = 3

})

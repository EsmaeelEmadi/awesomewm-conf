local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local os = os
local theme = {}

-- -- naughty
naughty.config.ontop = true
naughty.config.font = theme.font
naughty.timeout = 3
naughty.config.defaults["icon_size"] = 50
-- -- beautiful
beautiful.notification_font = theme.font
-- beautiful.notification_bg = "#0000000"
beautiful.size_hint_honor = true
beautiful.gap_single_client = true
beautiful.useless_gap = 5

theme.beautiful = beautiful
theme.naughty = naughty

theme.colors = require("themes.mine.colors")
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/mine"
theme.font = "JetbrainsMonoNerdFont 11"

-- -- taglist
theme.taglist_fg_focus = theme.colors.color6
theme.taglist_fg_occupied = theme.colors.color0
theme.taglist_bg_empty = nil
theme.taglist_fg_empty = nil
theme.taglist_font = "JetbrainsMonoNerdFont"
-- -- tasklist
theme.tasklist_fg_normal = theme.colors.foreground
theme.tasklist_bg_normal = "#1F1C2700"
theme.tasklist_fg_focus = "#d8b76e"
theme.tasklist_bg_focus = "#1F1C2700"
theme.tasklist_fg_minimize = "#1F1C2790"
-- -- useless gap
theme.useless_gap = dpi(10)

function theme.at_screen_connect(s)
	-- Quake application
	s.quake = lain.util.quake({ app = awful.util.terminal })

	-- Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts)

	local layout_box = require("themes.mine.layoutbox")(s)
	local my_wibar = require("themes.mine.my_wibar")(s, theme)
	local mytaglist = require("themes.mine.taglist")(s, theme)

	s.mypromptbox = require("themes.mine.promptbox")
	-- s.mylayoutbox = layout_box
	s.mywibox = my_wibar

	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		stretch = false,
		{
			layout = wibox.layout.fixed.horizontal,
		},
		{
			valign = "center",
			halign = "center",
			layout = wibox.layout.fixed.horizontal,
			mytaglist
		},
		{
			layout = wibox.layout.fixed.horizontal,
		},
	})
end

return theme

local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi

function My_wibox(s, theme)
	local my_wibox = awful.wibar({
		position = "bottom",
		screen = s,
		border_width = dpi(4),
		bg = "#0000000",
		fg = theme.colors.foreground,
		height = dpi(32),
	})

	return my_wibox
end

return My_wibox

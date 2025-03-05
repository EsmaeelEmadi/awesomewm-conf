local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi

function My_wibar(s, theme)
	local my_wibar = awful.wibar({
		position = "bottom",
		type = "dock",
		ontop = true,
		screen = s,
		bg = "#0000000",
		fg = theme.colors.foreground,
		height = dpi(12),
		border_width = dpi(3)
	})

	return my_wibar
end

return My_wibar

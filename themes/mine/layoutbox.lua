local awful = require("awful")
local gears = require("gears")
local my_table = awful.util.table or gears.table

local function Layout_box(s)
	local layout_box = awful.widget.layoutbox(s)
	layout_box:buttons(my_table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 2, function()
			awful.layout.set(awful.layout.layouts[1])
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	return layout_box
end

return Layout_box

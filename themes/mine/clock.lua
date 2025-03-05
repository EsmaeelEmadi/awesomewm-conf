local lain = require("lain")
local wibox = require("wibox")
local gears = require("gears")

local markup = lain.util.markup

function Clock(theme)
	local mytextclock = wibox.widget.textclock(markup(theme.colors.color0, "%H:%M"))

	mytextclock.font = theme.font

	local clock_box = wibox.container.background(wibox.container.margin(mytextclock, 20, 20, 5, 5))

	clock_box.bg = theme.colors.background

	clock_box.shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 4)
	end

	return clock_box
end

return Clock

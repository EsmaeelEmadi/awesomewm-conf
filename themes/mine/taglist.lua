local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local function update_tag(self, tag)
	if tag.selected then
		self:get_children_by_id("margin_role")[1].margins = 3
		self:get_children_by_id("wrapper_margin_role")[1].margins = 5
	else
		self:get_children_by_id("margin_role")[1].margins = 0
		self:get_children_by_id("wrapper_margin_role")[1].margins = 0
	end
end

local function Taglist(s, theme)
	-- Eminent-like task filtering
	local orig_filter = awful.widget.taglist.filter.all

	-- Taglist label functions
	awful.widget.taglist.filter.all = function(t, args)
		if t.selected or #t:clients() > 0 then
			return orig_filter(t, args)
		end
	end

	local mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = awful.util.taglist_buttons,
		style = {
			shape = gears.shape.powerline,
		},
		layout = {
			-- spacing = -12,
			spacing_widget = {
				color = theme.colors.color0,
				shape = gears.shape.powerline,
				widget = wibox.widget.separator,
			},
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				left = 0,
				right = 8,
				widget = wibox.container.margin,
				{
					-- shape = gears.shape.rounded_rect,
					shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, 4) -- Rounded corners (optional)
					end,
					widget = wibox.container.background,
					bg = theme.colors.background,
					{
						{
							id = "wrapper_margin_role",
							margins = 0,
							widget = wibox.container.margin,
						},
						{
							top = 0,
							widget = wibox.container.margin,
							{

								{
									id = "margin_role",
									margins = 0,
									widget = wibox.container.margin,
								},
								bg = theme.colors.color6,
								shape = gears.shape.circle,
								widget = wibox.container.background,
							},
						},
						{
							margins = 5,
							widget = wibox.container.margin,
						},
						{
							id = "text_role",
							widget = wibox.widget.textbox,
						},
						{
							margins = 5,
							widget = wibox.container.margin,
						},
						layout = wibox.layout.fixed.horizontal,
					},
				},
			},
			id = "background_role",
			widget = wibox.container.background,
			-- Add support for hover colors and an index label
			create_callback = function(self, tag, index, objects) --luacheck: no unused args
				update_tag(self, tag)
			end,
			update_callback = function(self, tag, index, objects) --luacheck: no unused args
				update_tag(self, tag)
			end,
		},
	})

	return mytaglist
end

return Taglist

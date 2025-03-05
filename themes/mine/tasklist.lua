local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local app_icons = {
	Code = "visual-studio-code",
	kitty = "kitty",
	firefox = "firefox",
	["Vivaldi-stable"] = "vivaldi",
	["Google-chrome"] = "google-chrome",
	Nitrogen = "wallpaper",
	-- Add more applications and their respective icons as needed
}

local icon_size = 128

local function resize_icon(icon_name, size)
	local svg_path = "/usr/share/icons/gruvbox-plus-icon-pack/Gruvbox-Plus-Dark/apps/scalable/" .. icon_name .. ".svg"
	local png_path = "/tmp/" .. icon_name .. icon_size .. ".png"
	local command = "convert -background none -resize " .. size .. "x" .. size .. " " .. svg_path .. " " .. png_path

	if not gears.filesystem.file_readable(png_path) then
		os.execute(command)
	end

	return png_path
end


-- Base template of the tasklist widget
local layout = {
	widget = wibox.layout.fixed.horizontal,
}

-- Individual tasklist entry template
local cell = {
	widget = wibox.layout.fixed.horizontal,

	{ widget = wibox.widget.imagebox },
	-- { widget = wibox.widget.textbox },
}

-- Called once per created tasklist
function cell:create_callback(c, index, clients)

	local children = self.children
	local imagebox = children[1]
	-- local imagebox, textbox = children[1], children[2]

	-- Set the icon
  local icon_png = resize_icon(app_icons[c.class], icon_size);

	imagebox.image = icon_png

	-- Also run the update callback immediately
	self:update_callback(c, index, clients)
end

-- Called every time particular set of properties of the client or tag change
-- See: https://github.com/awesomeWM/awesome/blob/master/lib/awful/widget/tasklist.lua#L974
function cell:update_callback(c, index, clients)
	-- local children = self.children
	-- local imagebox, textbox = children[1], children[2]
	--
	-- textbox.text = c.name or "Unknown"

	-- This is a good place to style your tasklist
	-- depending on whether client is selected, minimized, urgent, etc.
end

local function Tasklist(s, theme)
	local tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		layout = layout,
		widget_template = cell,
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		buttons = {
			awful.button({}, 1, function(c)
				c:activate({ context = "tasklist", action = "toggle_minimization" })
			end),
		},
	})

	return tasklist
end

return Tasklist


local awful = require("awful")

awful.spawn.with_shell("compton")
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("setxkbmap -model pc104 -layout us,ir -variant qwerty -option grp:ralt_rshift_toggle")
awful.spawn.with_shell("xrandr --output HDMI-1-0 --right-of eDP-1 --auto")
-- awful.spawn.with_shell("xrandr --output DP-1 --right-of eDP-1 --auto")

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local widget = {}

local function worker(args)
    local args = args or {}

    local time_to_update = args.time_to_update or 15 -- time to update CPU temperature in widget

    local widget = wibox.widget {
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox,
    }
    

    watch('bash -c "sensors | grep Package | cut -d \' \' -f 5 | sed -e s/+//g -e s/°C//g "',
        time_to_update,
        function(widget, stdout)
            stdout = string.gsub(stdout, "\n", "") -- remove line break so we can add "°C" at the end
            widget:set_text(" " .. stdout .. "°C")
        end,
    widget)

    return widget
end

return setmetatable(widget, { __call = function(_, ...)
    return worker(...)
end })
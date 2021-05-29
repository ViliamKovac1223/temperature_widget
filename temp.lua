local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local gears = require("gears")

local widget = {}

local function worker(args)
    local args = args or {}

    local time_to_update = args.time_to_update or 15 -- time to update CPU temperature in widget

    local widget = wibox.widget {
        align  = 'center',
        valign = 'center',
        text = "sdsa",
        widget = wibox.widget.textbox,
    }

    local container = wibox.widget {
        widget,
        shape = gears.shape.base,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        shape_border_color = beautiful.border_color,
        shape_border_width = beautiful.border_width,
        widget = wibox.container.background
    }
    

    watch('bash -c "sensors | grep Package | cut -d \' \' -f 5 | sed -e s/+//g -e s/°C//g "',
        time_to_update,
        function(container, stdout)
            stdout = string.gsub(stdout, "\n", "") -- remove line break so we can add "°C" at the end

            local temp = tonumber(stdout)
            if temp <= 30 then
                container.fg = "#90EE90"
            elseif temp <= 50 then
                container.fg = "#FFFF33"
            else
                container.fg = "#e70000"
            end

            widget:set_text(" " .. stdout .. "°C")
        end,
    container)

    return container
end

return setmetatable(widget, { __call = function(_, ...)
    return worker(...)
end })
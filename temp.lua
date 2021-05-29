local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local gears = require("gears")

local widget = {}

local function worker(args)
    local args = args or {}

    local time_to_update = args.time_to_update or 15 -- time to update CPU temperature in widget
    local shape = args.shape or gears.shape.base
    local font = args.font or 'Play 6'
    local bg = args.bg or beautiful.bg_normal
    local shape_border_color = args.shape_border_color or beautiful.border_color
    local shape_border_width = args.shape_border_width or beautiful.border_width

    local low_level_temp_fg = args.low_level_temp_fg or "#90EE90"
    local mid_level_temp_fg = args.mid_level_temp_fg or "#FFFF33" 
    local high_level_temp_fg = args.high_level_temp_fg or "#e70000"

    local low_level_temp = args.low_level_temp or 30
    local mid_level_temp = args.mid_level_temp or 50

    local widget = wibox.widget {
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox,
    }

    local container = wibox.widget {
        widget,
        shape = shape,
        font = font,
        bg = bg,
        fg = beautiful.fg_normal,
        shape_border_color = shape_border_color,
        shape_border_width = shape_border_width,
        widget = wibox.container.background
    }
    

    watch('bash -c "sensors | grep Package | cut -d \' \' -f 5 | sed -e s/+//g -e s/°C//g "',
        time_to_update,
        function(container, stdout)
            stdout = string.gsub(stdout, "\n", "") -- remove line break so we can add "°C" at the end

            local temp = tonumber(stdout)
            if temp <= low_level_temp then
                container.fg = low_level_temp_fg
            elseif temp <= mid_level_temp then
                container.fg = mid_level_temp_fg
            else
                container.fg = high_level_temp_fg
            end

            widget:set_text(" " .. stdout .. "°C")
        end,
    container)

    return container
end

return setmetatable(widget, { __call = function(_, ...)
    return worker(...)
end })

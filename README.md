# temperature_widget
CPU Temperature widget for awesome window manager.

## Installation

### 1) Get all the dependencies  

#### Debian-Based  
```
sudo apt install lm-sensors
```

#### Fedora-Based
```
sudo dnf install lm_sensors
```

#### Arch-Based
```
sudo pacman -S lm_sensors
```

### 2) Clone the widget
```
git clone https://github.com/ViliamKovac1223/temperature_widget.git ~/.config/awesome/temperature_widget
```

### 3) Add to awesome wm configuration
Add this code to your rc.lua (~/.config/awesome/rc.lua)
```lua
local temp_widget = require("temperature_widget.temp")
...
s.mytasklist, -- Middle widget
	{ -- Right widgets
		...
        temp_widget({
            time_to_update = 20,
            shape = gears.shape.base,
            font = 'Play 6',
            bg = beautiful.bg_normal,
            shape_border_color = beautiful.border_color,
            shape_border_width = beautiful.border_width,
            low_level_temp_fg = "#90EE90",
            mid_level_temp_fg = "#FFFF33",
            high_level_temp_fg = "#e70000",
            low_level_temp = 30,
            mid_level_temp = 50,
        }),
        ...
	}
	...
```

### 4) Restart your awesome wm 
Default shortcut for restarting awesome wm:
```
Mod4 + Control + r
``` 

## Options
time_to_update - Delay time in seconds to update a widget.
shape - Shape from gears (https://awesomewm.org/doc/api/libraries/gears.shape.html).
font - Font.
bg - Widget background.
shape_border_color - Border color of the shape.
shape_border_width - Border width of the shape.
low_level_temp_fg - Text color when temperature is low.
mid_level_temp_fg - Text color when temperature is medium.
high_level_temp_fg - Text color when temperature is high.
low_level_temp - Maximum value of temperature which is considered low.
mid_level_temp - Maximum value of temperature which is considered medium. Everything above is considered high.
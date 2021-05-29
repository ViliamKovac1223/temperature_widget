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
            time_to_update = 15
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
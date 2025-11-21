# Environment stuff
set DIR (dirname (status -f))
riverctl spawn "fish $DIR/xdg.fish"

# Display management
riverctl spawn "sh -c way-displays > /tmp/way-displays.$XDG_VTNR.$USER.log 2>&1"

# Workaround for asahi-audio not being started at launch
riverctl spawn "mpv $DIR/silent.wav"

# Idle management
riverctl spawn hypridle

# Cursor
riverctl xcursor-theme Moga-Candy-Black 32

# Wallpaper
riverctl spawn awww-daemon

# Quickshell
riverctl spawn qs

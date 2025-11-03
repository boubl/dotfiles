# Environment stuff
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river
systemctl --user restart xdg-desktop-portal

# Idle management
riverctl spawn hypridle

# Display management
riverctl spawn "sh -c way-displays > /tmp/way-displays.$XDG_VTNR.$USER.log 2>&1"

# Cursor
riverctl xcursor-theme Moga-Candy-Black 32

# Wallpaper
riverctl spawn awww-daemon

# Quickshell
riverctl spawn qs

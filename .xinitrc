# Use multiple monitors
xrandr --output DVI-I-1 --auto --output DVI-I-2 --auto --right-of DVI-I-1

# Set cursor to arrow
xsetroot -cursor_name left_ptr

#Turn off beep
xset -b

# Set desktop background
[[ -f ~/.fehbg ]] && . ~/.fehbg

# Add fonts to font path
xset +fp /usr/share/fonts/local
xset fp rehash

# Load .Xresources
xrdb ~/.Xresources

# Start xbindkeys
xbindkeys

# Start the panel
panel dzen2 &

# Start plank
plank &

# Start xscreensaver
xscreensaver -no-splash &

# Start compton for transparency
compton -Cc &

# Start up bspwm
sxhkd &
exec bspwm


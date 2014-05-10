# Reverse scroll direction
if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

# Enable auto supsend on idle
xautolock -time 5 -locker "sudo pm-suspend" -detectsleep &

# Set caps-lock to ctrl
setxkbmap -option ctrl:nocaps

# Set power optimizations
sudo powerdown

# screen powersave
xset +dpms
xset dpms 0 0 240

# Launch AwesomeWM
exec dbus-launch awesome


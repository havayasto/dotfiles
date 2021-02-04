# load Xresources file
xrdb -merge $HOME/.Xresources

# I'm not only a fan of tiling WMs, but also of tiling Wallpapers
# xsetroot conflicts with xcompmgr
xsetroot -bg \#939393 -mod 2 2 &

# start a simple composite manager for more elegant desktop
# xcompmgr -c -r10 -F -f -D5 -C -o0.8 &

# set bulgarian keyboard layout for the current X session
setxkbmap -model pc105 -layout us,bg -variant  ,phonetic -option grp:alt_shift_toggle &

# start awesome window manager
openbsd-cwm

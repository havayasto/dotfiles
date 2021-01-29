# load Xresources file
xrdb -merge $HOME/.Xresources

xcompmgr -c -r10 -F -f -D5 -C -o0.8 &

awesome

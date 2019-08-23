#!/bin/bash
echo Hello World
vnc4server -geometry 1600x800 > /tmp/vncserver.out 2>&1
export DISPLAY=$(hostname):1
export XFCE_PANEL_MIGRATE_DEFAULT=true
xfce4-session &
xhost +
# sets the default to xfce4-terminal
echo 2 | update-alternatives --config x-terminal-emulator
# xfce4-terminal &
xfce4-terminal --maximize &

#
service nginx start
/usr/sbin/sshd -D

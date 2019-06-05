#!/bin/bash
echo Hello World
vnc4server > /tmp/vncserver.out 2>&1
export DISPLAY=$(hostname):1
export XFCE_PANEL_MIGRATE_DEFAULT=true
xfce4-session &
xfce4-terminal &
/usr/sbin/sshd -D

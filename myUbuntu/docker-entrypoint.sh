#!/bin/bash
echo Hello World
vnc4server > /tmp/vncserver.out 2>&1
export DISPLAY=$(hostname):1
gnome-terminal
/usr/sbin/sshd -D

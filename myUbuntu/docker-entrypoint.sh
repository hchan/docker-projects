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

service nginx start
#########################
# Ways to forward ports #
#########################
# https://unix.stackexchange.com/questions/57721/how-to-forward-a-port-from-one-machine-to-another
# https://unix.stackexchange.com/questions/10428/simple-way-to-create-a-tunnel-from-one-local-port-to-another
# ssh -L 18888:localhost:80 -N -o GatewayPorts=yes localhost
# iptables -t nat -A PREROUTING -p tcp --dport 18888 -j REDIRECT --to-port 80
##### Note the iptables soln requires that you add --cap-add=NET_ADMIN to your docker run
# socat tcp-listen:18888,reuseaddr,fork tcp:localhost:80
# nc -l -p 18888 -c 'nc localhost 80'
nc -l -p 18888 -c 'nc localhost 80' &




/usr/sbin/sshd -D

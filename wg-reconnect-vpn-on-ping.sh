#! /bin/sh
# Choose the name of the wireguard tunnel you want to stop and start here
WG_TUNNEL=wg1
PING_TARGET=1.1.1.1

# with help from https://unix.stackexchange.com/questions/184266/bash-ping-script-file-for-checking-host-availability
echo "Stopping Wireguard tunnel $WG_TUNNEL"
sudo systemctl stop wg-quick@$WG_TUNNEL.service
echo "Wireguard tunnel $WG_TUNNEL stopped"
while ! ping -c1 -i0.25 $PING_TARGET &>/dev/null
    do echo "No ping to server - $(date)"
done
echo "Successful ping to server $PING_TARGET: guard the wires - $(date)"
sudo systemctl start wg-quick@$WG_TUNNEL.service
echo "Wireguard tunnel $WG_TUNNEL started"

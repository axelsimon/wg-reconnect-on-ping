#! /bin/sh
# Relies on iw, wireguard, awk, and assumes network-manager (nmcli)
# Choose the name of the wireguard tunnel you want to stop and start here
WG_TUNNEL=wg1
WIFI_INTERFACE=$(iw dev | awk '$1=="Interface"{print $2}')
PING_TARGET=1.1.1.1
CURRENT_CONNECTION=$(nmcli -g general.connection device show $WIFI_INTERFACE)

# with help from https://unix.stackexchange.com/questions/184266/bash-ping-script-file-for-checking-host-availability
echo "Stopping Wireguard tunnel $WG_TUNNEL"
sudo systemctl stop wg-quick@$WG_TUNNEL.service
echo "Wireguard tunnel $WG_TUNNEL stopped"
printf "\n"
echo "Reconnecting to Wifi connection $CURRENT_CONNECTION"
echo "Result:"
nmcli connection up $CURRENT_CONNECTION
printf "\n"
echo "Trying to ping…"
while ! ping -c1 -i0.25 $PING_TARGET >/dev/null 2>&1
    do echo "No ping to server - $(date)"
done
printf "\n"
echo "Successful ping to server $PING_TARGET: guard the wires - $(date)"
sudo systemctl start wg-quick@$WG_TUNNEL.service
printf "\n"
echo "Wireguard tunnel $WG_TUNNEL started"

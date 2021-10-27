# wg-reconnect-on-ping

A dead simple script that stops a Wiregard tunnel, continuously pings the
Wireguard host and reconnects upon successful ping.

Useful for temporarily stopping Wireguard tunnel and logging into a public Wifi
hotspot, but quickly reconnecting as soon as possible.

I suppose this is for those too lazy to set-up proper [network namespace
routing](https://www.wireguard.com/netns/), as described in the Wireguard
documentation. If like me, you will "get around to doing that one day", this
might be of use in the meantime.

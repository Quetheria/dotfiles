#!/usr/bin/env bash

bat=$(< /sys/class/power_supply/BAT0/capacity)

private=$(ip addr show wlp2s0 | grep 'inet ' | awk '{print $2}' | cut -d / -f 1)
date=$(date +'%Y-%m-%d %X')
chg=$'Charging\n'
if [[ $(cat /sys/class/power_supply/BAT0/status) = $(echo -n "$chg") ]]; then
	echo '🛜 priv: '$private' | 🔋 '$bat'% Charging | '$date
else

	echo '🛜 priv: '$private' | 🔋 '$bat'% | '$date
fi





#public=$(wget -q -O - ipinfo.io/ip)


#pubret=$?


#if [ $pubret -eq 0 ]; then
#	pubaddr=$public
#	echo -n 'Pub: '$public' | '
#else
#	echo -n 'Pub: '$pubaddr' | '

#fi

#vpn=$(ip addr show tun0 | grep 'inet ' | awk '{print $2}' | cut -d / -f 1)

#vpnret=$?


#if [ $vpnret -eq 0 ]; then
#	echo -n 'VPN: '$vpn' | '
#	vpnaddr=$vpn
#else
#	echo -n 'VPN: '$vpnaddr' | '

#fi


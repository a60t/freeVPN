#!/bin/sh

echo Download Lists 
wget -q -O /opt/etc/rublock/rublock.dnsmasq https://raw.githubusercontent.com/a60t/freeVPN/master/urlblock
wget -q -O /opt/etc/rublock/rublock.ips https://raw.githubusercontent.com/a60t/freeVPN/master/ipblock

echo Generation Block List
cd /opt/etc/rublock
sed -i 's/.*/ipset=\/&\/rublock/' rublock.dnsmasq

echo Add ip
ipset flush rublock

for IP in $(cat /opt/etc/rublock/rublock.ips) ; do
ipset -A rublock $IP
done

echo Restart dnsmasq
killall -q dnsmasq
/usr/sbin/dnsmasq

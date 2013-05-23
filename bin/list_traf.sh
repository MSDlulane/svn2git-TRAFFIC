#!/bin/bash
TRAFHOME="/opt/mhg/TRAFFIC"
HOSTNAME=$(hostname)
echo ""
echo "Traffic servers for host, $HOSTNAME:"
OLD_IFS=$IFS
IFS=$'\r\n'
header="\n%-20s %-30s %-13s %-9s\n"
row="%-20s %-30s %-13s %-9s\n"
printf "$header" "CONFIG-NAME" "RC-SCRIPT-NAME" "SCRIPT-EXISTS" "RC-CONFIG"
printf "$row" "-----------" "--------------" "-------------" "---------"
for trafconfig in $(grep "$HOSTNAME" "$TRAFHOME/bin/traffic_server_list.txt")
do
	trafname=$(echo "$trafconfig" | awk '{print $2}')
	scriptname="traffic-$trafname"
	scriptinstalled="0"
	if [ -f "/etc/init.d/$scriptname" ]; then
		scriptinstalled="1"
	fi
	rcconfig=$(/sbin/chkconfig --list $scriptname |grep -c "3:on	4:on	5:on")
	printf "$row" "$trafname" "$scriptname" "$scriptinstalled" "$rcconfig"
done
echo ""

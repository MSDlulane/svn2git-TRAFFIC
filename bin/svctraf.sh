#!/bin/bash
TRAFHOME="/opt/mhg/TRAFFIC"
HOSTNAME=$(hostname)
OPERATION=$1
if [ "$OPERATION" != "status" ]; then
	OLD_IFS=$IFS
	IFS=$'\r\n'
	for trafconfig in $(grep "$HOSTNAME" "$TRAFHOME/bin/traffic_server_list.txt")
	do
		trafname=$(echo "$trafconfig" | awk '{print $2}')
		scriptname="traffic-$trafname"
		rcconfig=$(/sbin/chkconfig --list $scriptname |grep -c "3:on	4:on	5:on")
		if [ -f "/etc/init.d/$scriptname" ]; then
			if [ "$rcconfig" = "1" ]; then
				/sbin/service "$scriptname" $OPERATION > /dev/null
			fi
		fi
	done
	IFS=$OLD_IFS
fi

echo ""
echo "Traffic servers for host, $HOSTNAME:"
OLD_IFS=$IFS
IFS=$'\r\n'
header="\n%-20s %-45s\n"
row="%-20s %-45s\n"
printf "$header" "CONFIG-NAME" "SERVICE-STATUS"
printf "$row" "-----------" "--------------" 
for trafconfig in $(grep "$HOSTNAME" "$TRAFHOME/bin/traffic_server_list.txt")
do
	trafname=$(echo "$trafconfig" | awk '{print $2}')
	scriptname="traffic-$trafname"
	servicestatus=$(/sbin/service $scriptname status 2>&1 |awk '{for(i=2;i<=NF;i++){ printf $i" " } print ""}')
	printf "$row" "$trafname" "$servicestatus"
done
IFS=$OLD_IFS
echo ""

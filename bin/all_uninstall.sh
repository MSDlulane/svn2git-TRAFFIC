#!/bin/bash
TRAFHOME="/opt/mhg/TRAFFIC"
HOSTNAME=$(hostname)
for TRAF in $(grep "$HOSTNAME" "$TRAFHOME/conf/traffic_server_list.txt" | awk '{print $2}')
do
	echo "Invoking uninstall for: $TRAF ..."
	"$TRAFHOME/bin/uninstall.sh" "$TRAF"
done

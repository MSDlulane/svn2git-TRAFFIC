#!/bin/bash
TRAFHOME="/opt/mhg/TRAFFIC"
HOSTNAME=$(hostname)
for TRAF in $(grep "$HOSTNAME" "$TRAFHOME/etc/traffic_server_list.txt" | awk '{print $2}')
do
	echo "Invoking install for: $TRAF ..."
	"$TRAFHOME/bin/install.sh" "$TRAF"
done
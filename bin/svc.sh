#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
HOSTNAME=$(hostname)
TRAFNAME=$1
OPERATION=$2
CONFIGKEY="$HOSTNAME $TRAFNAME "
EXISTS=$(grep -c "$CONFIGKEY" "$TRAFHOME/etc/traffic_server_list.txt")
if [ "$EXISTS" = "1" ]; then
	service "traffic-$TRAFNAME" $OPERATION
	exit $?
else
	echo "\"$TRAFNAME\" is not configured for \"$HOSTNAME\". Abort."
	exit 1
fi

#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
TRAFNAME=$1
HOSTNAME=$2
OPERATION=$3
CONFIGKEY="$HOSTNAME $TRAFNAME "
EXISTS=$(grep -c "$CONFIGKEY" "$TRAFHOME/conf/traffic_server_list.txt")
if [ "$EXISTS" = "1" ]; then
	/sbin/service "traffic-$TRAFNAME" $OPERATION
	exit $?
else
	echo "\"$TRAFNAME\" is not configured for \"$HOSTNAME\". Abort."
	exit 1
fi

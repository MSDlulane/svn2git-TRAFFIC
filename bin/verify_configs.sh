#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
TRAFLIST=$TRAFHOME/etc/traffic_server_list.txt
echo "Find config dir in \"$TRAFHOME/etc\" for entries in \"$TRAFLIST\"."
OLD_IFS=$IFS
IFS=$'\n'
for trafid in $(grep -v '^#' $TRAFLIST)
do
	TRAFCONFIG=$(grep $trafid $TRAFLIST | awk '{print $2}')
	if [ -d "$TRAFHOME/etc/$TRAFCONFIG" ]; then
		echo "OK, $TRAFCONFIG has config."
	else
		echo "ERROR, $TRAFCONFIG has no config."
	fi
done
IFS=$OLD_IFS
echo "Find entries in\"TRAFLIST\" for config dir's in \"$TRAFHOME/etc\"."
for trafconfig in $TRAFHOME/etc/*
do
	if [ -d "$trafconfig" ]; then
		config=$(basename $trafconfig)
		count=$(grep -c "$config " $TRAFLIST)
		if [ "$count" = "0" ]; then
			echo "ERROR, $config is not listed for any hosts."
		else
			echo -n "OK, $config is listed for hosts: "
			suffix=""
			for host in $(grep $config $TRAFLIST | awk '{print $1}')
			do
				echo -n "$host"
				echo -n "$suffix"
				suffix=", "
			done
			echo ""
		fi
	fi
done

#!/bin/bash
TRAFHOME="/opt/mhg/TRAFFIC"
HOSTNAME=$(hostname)
TRAFNAME_PARAM=$1
TRAFNAME=$(grep "$HOSTNAME $TRAFNAME_PARAM" "$TRAFHOME/conf/traffic_server_list.txt" | awk '{print $2}')
if [ "$TRAFNAME" = "" ]; then
	echo "The TRAF service $TRAFNAME_PARAM is not configured for this host, $HOSTNAME. Aborting."
fi
SCRIPTNAME=traffic-$TRAFNAME
echo "Delete rc.d config..."
/sbin/chkconfig --del $TRAFNAME_PARAM
if [ -f /etc/init.d/$SCRIPTNAME ]; then
	echo "Delete init.d script..."
	rm /etc/init.d/$SCRIPTNAME
else
	echo "The init script \"$SCRIPTNAME\" does not exist."
fi
TRAFLOGDIR="/var/opt/mhg/log/TRAFFIC/$TRAFNAME"
TRAFLOGLINK="$TRAFHOME/etc/$TRAFNAME/log"
echo "All possible rc.d config has been removed."
echo "Log directory and soft-link: "
echo "	- $TRAFLOGDIR"
echo "	- $TRAFLOGLINK"
echo "are retained for backup purposes. Please delete them manually."
echo "Done."

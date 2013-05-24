#!/bin/bash
TRAFHOME="/opt/mhg/TRAFFIC"
HOSTNAME=$(hostname)
TRAFNAME_PARAM=$1
TRAFNAME=$(grep "$HOSTNAME $TRAFNAME_PARAM " "$TRAFHOME/conf/traffic_server_list.txt" | awk '{print $2}')
if [ "$TRAFNAME" = "" ]; then
	echo "The TRAF service $TRAFNAME_PARAM is not configured for this host, $HOSTNAME. Aborting."
	exit 2
fi
SCRIPTNAME=traffic-$TRAFNAME
TRAFHOME_PARAM=$(echo "$TRAFHOME" | sed 's/\//\\\//g')
TRAFLOGDIR="/var/opt/mhg/log/TRAFFIC/$TRAFNAME"
TRAFLOGLINK="$TRAFHOME/etc/$TRAFNAME/log"
echo "Make log directory $TRAFLOGDIR..."
mkdir -p $TRAFLOGDIR
chown mhgsvc:mhgsvc $TRAFLOGDIR
if [ -f "${TRAFLOGLINK}" ]; then
	echo "Soft-link $TRAFLOGLINK exists."
else
	echo "Make log soft-link $TRAFLOGLINK..."
	ln -s "$TRAFLOGDIR" "$TRAFLOGLINK"
fi
echo "Configuration retrieved for: $TRAFNAME_PARAM"
echo "Copying template script..."
cp "$TRAFHOME/bin/startup_template.sh" "/etc/init.d/$SCRIPTNAME"
echo "Setting TRAFHOME variable..."
sed -i "s/__TRAFHOME/$TRAFHOME_PARAM/g" "/etc/init.d/$SCRIPTNAME"
echo "Setting TRAFNAME variable..."
sed -i "s/__TRAFNAME/$TRAFNAME/g" "/etc/init.d/$SCRIPTNAME"
echo "Setting script permissions variable..."
chmod 744 "/etc/init.d/$SCRIPTNAME"
echo "Setting script ownership..."
chown root:root "/etc/init.d/$SCRIPTNAME"
echo "Adding rc.d config..."
/sbin/chkconfig --add "$SCRIPTNAME"
echo "Done."

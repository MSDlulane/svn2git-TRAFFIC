#!/bin/bash
TRAFHOME="/opt/mhg/TRAFFIC"
HOSTNAME=$(hostname)
TRAFNAME=$1
TRAFPROCNAME=traffic-$TRAFNAME

TRAFLIST=$TRAFHOME/etc/traffic_server_list.txt
TRAFLIB=$(grep "$HOSTNAME $TRAFNAME" $TRAFLIST | awk '{print $3}')
TRAFENABLED=$(grep "$HOSTNAME $TRAFNAME" $TRAFLIST | awk '{print $4}')
TRAFSTARTMEM=$(grep "$HOSTNAME $TRAFNAME" $TRAFLIST | awk '{print $5}')
TRAFMAXMEM=$(grep "$HOSTNAME $TRAFNAME" $TRAFLIST | awk '{print $6}')
TRAFJMXPORT=$(grep "$HOSTNAME $TRAFNAME" $TRAFLIST | awk '{print $7}')
TRAFDIR=$TRAFHOME/etc/$TRAFNAME

echo ""
if [ "$TRAFENABLED" = "ENABLED" ]; then
	echo "$TRAFPROCNAME Service is enabled."
else
	if [ "$TRAFENABLED" = "" ]; then
		echo "$TRAFPROCNAME Service is NOT listed in \"$TRAFLIST\". Abort."
		exit 1
	fi
	echo "$TRAFPROCNAME Service is NOT enabled. TRAF will not start. Abort."
	exit 2
fi

TRAFJMXSETTINGS=""
TRAFSNMPSETTINGS=""
if [ "$TRAFJMXPORT" = "" ]; then
	echo "TRAF JMX/SNMP port is not configured. TRAF will not start. Abort."
	exit 4
else
	echo "TRAF JMX/SNMP port set to #$TRAFJMXPORT."
	TRAFJMXSETTINGS="-Dcom.sun.management.jmxremote.port=$TRAFJMXPORT -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
	TRAFSNMPSETTINGS="-Dcom.sun.management.snmp.acl.file=$TRAFHOME/etc/snmp.acl -Dcom.sun.management.snmp.port=$TRAFJMXPORT -Dcom.sun.management.snmp.interface=0.0.0.0"
fi

if [ -d  "$TRAFHOME/lib/$TRAFLIB" ]; then
	echo "Using library \"$TRAFLIB\"."
else
	echo "\"$TRAFLIB\" does not exist. Abort."
	exit 8 
fi

TRAFSTARTMEM_OPT=""
if [ "$TRAFSTARTMEM" != "-1" ]; then
	echo "JVM will allocate $TRAFSTARTMEM mb heap at start-up."
	TRAFSTARTMEM_OPT="-Xms$TRAFSTARTMEMm "
else
	echo "JVM start heap-size not set."
fi

TRAFMAXMEM_OPT=""
if [ "$TRAFMAXMEM" != "-1" ]; then
	echo "JVM will allocate maximum $TRAFSTARTMEM mb heap at runtime."
	TRAFMAXMEM_OPT="-Xmx$TRAFMAXMEMm"
else
	echo "JVM max heap-size not set."
fi
TRAFMEMSETTINGS="$TRAFSTARTMEM_OPT $TRAFMAXMEM_OPT"

cd "$TRAFDIR"
exec -a "$TRAFPROCNAME" java -server $TRAFMEMSETTINGS $TRAFJMXSETTINGS -jar "$TRAFHOME/lib/$TRAFLIB/TRAF.jar" "$TRAFDIR/config.xml" >/dev/null 2>/dev/null &
echo $! > /var/run/mhgsvc/${TRAFPROCNAME}.pid

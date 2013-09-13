#!/bin/bash
HOSTNAME=$1
TRAFHOME=$2
TRAFNAME=$3


if [ "${HOSTNAME}" = "" ]; then
	echo "Please specify a hostname."
	exit 1
fi

if [ "${TRAFHOME}" = "" ]; then
	echo "Please specify a hostname."
	exit 2
fi

if [ "${TRAFNAME}" = "" ]; then
	echo "Please specify a hostname."
	exit 4
fi

TRAFPROCNAME=traffic-$TRAFNAME

TRAFLIST=$TRAFHOME/conf/traffic_server_list.txt
TRAFLIB=$(grep "$HOSTNAME $TRAFNAME " $TRAFLIST | awk '{print $3}')
TRAFENABLED=$(grep "$HOSTNAME $TRAFNAME " $TRAFLIST | awk '{print $4}')
TRAFSTARTMEM=$(grep "$HOSTNAME $TRAFNAME " $TRAFLIST | awk '{print $5}')
TRAFMAXMEM=$(grep "$HOSTNAME $TRAFNAME " $TRAFLIST | awk '{print $6}')
TRAFJMXPORT=$(grep "$HOSTNAME $TRAFNAME " $TRAFLIST | awk '{print $7}')
TRAFDIR=$TRAFHOME/etc/$TRAFNAME

echo ""
echo "Traffic Server Test only startup."
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
	echo "TRAF JMX [_ONLY_] port set to #$TRAFJMXPORT."
#	TRAFJMXSETTINGS="-Dcom.sun.management.jmxremote.port=$TRAFJMXPORT -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
	TRAFJMXSETTINGS="-Xdebug -Xrunjdwp:transport=dt_socket,address=${TRAFJMXPORT},server=y,suspend=n"
fi

if [ -d  "$TRAFHOME/lib/$TRAFLIB" ]; then
	echo "Using library \"$TRAFLIB\"."
else
	echo "\"$TRAFLIB\" does not exist. Abort."
	exit 8 
fi

TRAFSTARTMEM_OPT=""
echo "Ignoring JVM start heap-size."

TRAFMAXMEM_OPT=""
echo "Ignoring JVM max heap-size."

TRAFMEMSETTINGS="$TRAFSTARTMEM_OPT $TRAFMAXMEM_OPT"
mkdir ${TRAFDIR}/log
cd "$TRAFDIR"
nohup java -server $TRAFMEMSETTINGS $TRAFSNMPSETTINGS $TRAFJMXSETTINGS -jar "$TRAFHOME/lib/$TRAFLIB/TRAF.jar" "$TRAFDIR/config.xml" >"$TRAFDIR/log/stdout" 2>"$TRAFDIR/log/stderr" &
echo "$TRAFNAME $!" >> $TRAFHOME/dbin/pids

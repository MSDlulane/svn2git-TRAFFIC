#!/bin/bash
TRAFHOME="/opt/mhg/TRAFFIC"
HOSTNAME=$(hostname)
for TRAF in $(grep "$HOSTNAME" "$TRAFHOME/conf/traffic_server_list.txt" | awk '{print $2}')
do
	echo "Invoking install for: $TRAF ..."
	"$TRAFHOME/bin/install.sh" "$TRAF"
done
chown mhgsvc:mhgsvc ${TRAFHOME}/conf/snmp.acl
chmod 400 ${TRAFHOME}/bin/*.sh
chown root:mhgsvc ${TRAFHOME}/bin/*.sh
chmod 554 ${TRAFHOME}/bin/*.sh

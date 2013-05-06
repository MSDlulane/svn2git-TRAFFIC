#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
SSH_USER=""
TRAFNAME=$2
DATESTAMP=$(date '+%Y%m%d_%H%M%S')
for TRAFNAME in "$@"
do
	if [ "$SSH_USER" = "" ]; then
		SSH_USER=$TRAFNAME
	else
		OLD_IFS=$IFS
		IFS=$'\r\n'
		for hostname in $(grep " $TRAFNAME " "$TRAFHOME/etc/traffic_server_list.txt" | awk '{print $1}' | sort | uniq)
		do
			ssh "$SSH_USER$hostname" "sudo $TRAFHOME/bin/perform_deploy.sh" > "deployment_$DATESTAMP"
		done
		IFS=$OLD_IFS
	fi
done
#git add --all
#git commit -m "Deployment completed."

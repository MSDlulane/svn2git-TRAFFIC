#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
SSH_USER=$1
REV_NR=$2
DATESTAMP=$(date '+%Y%m%d_%H%M%S')
OPERATION="rollback_"
if [ "$REV_NR" = "" ]; then
	echo "Performing deployment..."
	OPERATION="deployment_"
else
	echo "Performing rollback..."
fi

if [ "$SSH_USER" = "" ]; then
	echo "No SSH user specified. Abort."
	exit 1
else
	OLD_IFS=$IFS
	IFS=$'\r\n'
	for hostname in $(grep -v "^#" "$TRAFHOME/etc/traffic_server_list.txt" | awk '{print $1}' | sort | uniq)
	do
		ssh -t "${SSH_USER}@${hostname}" "sudo $TRAFHOME/bin/perform_deploy.sh $REV_NR" |tee "${OPERATION}${DATESTAMP}"
	done
	IFS=$OLD_IFS
fi
echo "Adding deployment log to SVN repository..."
svn add ./* 
svn ci -m "Deployment completed: ${SSH_USER}."
echo "Done."

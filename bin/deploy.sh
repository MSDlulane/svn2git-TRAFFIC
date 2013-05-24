#!/bin/bash
svn update ../
trafHome=/opt/mhg/TRAFFIC
sshUser=$1
shift
dateStamp=$(date '+%Y%m%d_%H%M%S')
logFile="logs/deployment/${dateStamp}"

if [ "$sshUser" = "" ]; then
	echo "No SSH user specified. Abort."
	exit 1
fi

while true; do
	if [ $1 ]; then
		echo 'ssh -t "${trafUser}@$1" "sudo $trafHome/bin/perform_deploy.sh"' '2>&1' '| tee "${logFile}"'
		shift
	else
		break
	fi	
done
echo "Adding deployment log to SVN repository..." |tee -a "${logFile}"
svn add ./* 2>&1 | grep -v "is already under version control" |tee -a "${logFile}"
svn ci -m "Deployment completed: ${sshUser}." |tee -a "${logFile}"
svn update
echo "Done."


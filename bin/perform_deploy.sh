#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
SSH_STR=$1
ROLLBACK_REV=$2
if [ "$ROLLBACK_REV" = "" ]; then
	echo "New config deploy..."
else
	echo "Rolling back to revision #$ROLLBACK_REV..."
fi
$TRAFHOME/bin/svctraf.sh
$TRAFHOME/bin/deploy.sh $ROLLBACK_REV
$TRAFHOME/bin/svctraf.sh
if [ -f "$TRAFHOME/bin/backup_deploy.sh" ]; then
	echo "Removing rollback artifacts..."
	mv "$TRAFHOME/bin/backup_deploy.sh" "$TRAFHOME/bin/deploy.sh"
fi

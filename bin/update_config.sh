#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
INITIAL_REV=$(svn info "$TRAFHOME" | grep Revision |awk '{print $2}')
EXP_NEXT_REV=$((INITIAL_REV+1))
ROLLBACK_REV=$1
if [ "$ROLLBACK_REV" = "" ]
	echo "Retrieving latest configuration..."
	svn update "$TRAFHOME"
	NEW_REV=$(svn info "$TRAFHOME" | grep Revision |awk '{print $2}')
	if [ "$INITIAL_REV" = "$NEW_REV" ]; then
		echo "No changes were detected."
	else
		echo "Summary of (A)dded and (M)odified files."
		svn log -v -r "$EXP_NEXT_REV":"$NEW_REV" "$TRAFHOME" |egrep "^   (A|M)"
	fi
else
	cp "$TRAFHOME/bin/deploy.sh" "/tmp/rollback_${ROLLBACK_REV}_deploy.sh"
	echo "Rolling back to revision #$ROLLBACK_REV..."
	svn update -r$ROLLBACK_REV "$TRAFHOME"
	mv "$TRAFHOME/bin/deploy.sh" "$TRAFHOME/bin/backup_deploy.sh"
	cp "/tmp/rollback_deploy.sh" "$TRAFHOME/bin/deploy.sh"
fi
# Done.

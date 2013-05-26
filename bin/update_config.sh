#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
INITIAL_REV=$(svn info "$TRAFHOME" | grep Revision |awk '{print $2}')
EXP_NEXT_REV=$((INITIAL_REV+1))
ROLLBACK_REV=$1

do_update() {
	echo "Retrieving latest configuration..."
	svn update "$TRAFHOME"
	NEW_REV=$(svn info "$TRAFHOME" | grep Revision |awk '{print $2}')
	if [ "$INITIAL_REV" = "$NEW_REV" ]; then
		echo "No changes were detected."
	else
		echo "Summary of (A)dded and (M)odified files."
		svn log -v -r "$EXP_NEXT_REV":"$NEW_REV" "$TRAFHOME" |egrep "^   (A|M)"
	fi
}

svn info ${TRAFHOME}
if [ "$ROLLBACK_REV" = "" ]; then
	do_update
else
	cp "$TRAFHOME/conf/deployment.instructions" "/tmp/rollback_${ROLLBACK_REV}_deployment.instructions"
	echo "Rolling back to revision #$ROLLBACK_REV..."
	svn update -r$ROLLBACK_REV "$TRAFHOME"
	mv "$TRAFHOME/conf/deployment.instructions" "$TRAFHOME/conf/backup_deployment.instructions"
	cp "/tmp/rollback_${ROLLBACK_REV}_deployment.instructions" "$TRAFHOME/conf/deployment.instructions"
fi
# Done.

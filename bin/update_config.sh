#!/bin/bash
INITIAL_REV=$(svn info | grep Revision |awk '{print $2}')
EXP_NEXT_REV=$((INITIAL_REV+1))
cd /opt/mhg/TRAFFIC/
svn update
NEW_REV=$(svn info | grep Revision |awk '{print $2}')
if [ "$INITIAL_REV" = "$NEW_REV" ]; then
	echo "No changes were detected."
else
	echo "Summary of (A)dded and (M)odified files."
	svn diff "$EXP_NEXT_REV":"$NEW_REV" |egrep "^   (A|M)"
fi

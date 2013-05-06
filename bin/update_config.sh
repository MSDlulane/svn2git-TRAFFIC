#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
INITIAL_REV=$(svn info "$TRAFHOME" | grep Revision |awk '{print $2}')
EXP_NEXT_REV=$((INITIAL_REV+1))
cd $TRAFHOME
svn update
NEW_REV=$(svn info "$TRAFHOME" | grep Revision |awk '{print $2}')
if [ "$INITIAL_REV" = "$NEW_REV" ]; then
	echo "No changes were detected."
else
	echo "Summary of (A)dded and (M)odified files."
	svn diff "$EXP_NEXT_REV":"$NEW_REV" |egrep "^   (A|M)"
fi

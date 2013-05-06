#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
INITIAL_REV=$(svn info "$TRAFHOME" | grep Revision |awk '{print $2}')
EXP_NEXT_REV=$((INITIAL_REV+1))
cd $TRAFHOME
svn update "$TRAFHOME"
NEW_REV=$(svn info "$TRAFHOME" | grep Revision |awk '{print $2}')
if [ "$INITIAL_REV" = "$NEW_REV" ]; then
	echo "No changes were detected."
else
	echo "Summary of (A)dded and (M)odified files."
	svn log -v -r "$EXP_NEXT_REV":"$NEW_REV" "$TRAFHOME" |egrep "^   (A|M)"
fi

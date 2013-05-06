#!/bin/bash
INITIAL_REV=$(svn info | grep Revision |awk '{print $2}')
cd /opt/mhg/TRAFFIC/
svn update
NEW_REV=$(svn info | grep Revision |awk '{print $2}')
if [ "$INITIAL_REV" = "$NEW_REV" ]; then
	echo "No changes were detected."
else
	svn diff "$INITIAL_REV":"$NEW_REV"
fi

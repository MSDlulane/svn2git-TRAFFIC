#!/bin/bash
for oldtraf in /etc/init.d/traf-*
do
	echo "Removing \"rc.d\" configuration for $(basename $oldtraf)..."
	/sbin/chkconfig --del $(basename $oldtraf)
	echo "Deleting start-up script for $(basename $oldtraf)..."
	rm $oldtraf
done

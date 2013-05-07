#!/bin/bash
###
# Only the shell utilities listed below 
# should be used in this script.
#
# - /opt/mhg/TRAFFIC/bin/all_install.sh
# - /opt/mhg/TRAFFIC/bin/all_uninstall.sh
# - /opt/mhg/TRAFFIC/bin/debug_startup.sh
# - /opt/mhg/TRAFFIC/bin/deploy.sh
# - /opt/mhg/TRAFFIC/bin/install.sh
# - /opt/mhg/TRAFFIC/bin/list_traf.sh
# - /opt/mhg/TRAFFIC/bin/perform_deploy.sh
# - /opt/mhg/TRAFFIC/bin/remote.sh
# - /opt/mhg/TRAFFIC/bin/svc.sh
# - /opt/mhg/TRAFFIC/bin/svctraf.sh
# - /opt/mhg/TRAFFIC/bin/traf.sh
# - /opt/mhg/TRAFFIC/bin/traf-debug.sh
# - /opt/mhg/TRAFFIC/bin/uninstall.sh
# - /opt/mhg/TRAFFIC/bin/update_config.sh
# - /opt/mhg/TRAFFIC/bin/verify_configs.sh
####
###
# The line below will restart the "Mhg_ACPT" TRAF 
# server. To modify this, find the traffic server
# name in the file "$TRAFHOME/etc/traffic_server_list.txt"
# and replace the name
#/opt/mhg/TRAFFIC/bin/svc.sh Mhg_ACPT restart
echo "Done."

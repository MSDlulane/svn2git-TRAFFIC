#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
SSH_STR=$1
$TRAFHOME/bin/svctraf.sh
$TRAFHOME/bin/deploy.sh
$TRAFHOME/bin/svctraf.sh

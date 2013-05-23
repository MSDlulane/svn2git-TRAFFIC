#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
HOSTNAME=$(hostname)
TRAFNAME=$1
OPERATION=$2
${TRAFHOME}/bin/traf_service.sh ${TRAFNAME} ${HOSTNAME} ${OPERATION}

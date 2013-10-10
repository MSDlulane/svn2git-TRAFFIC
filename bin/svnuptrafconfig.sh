#!/bin/bash
TRAF_DIR=$(basname $(basename $0))
TRAFLOGDIR="/var/opt/mhg/log/TRAFFIC/"
DEPLLOGDIR=${TRAFLOGDIR}/deployment_logs
if [ -d "${DEPLLOGDIR}" ]; then
	echo "Creating ${DEPLLOGDIR}..."
	mkdir -p ${DEPLLOGDIR}
fi
LOG_FILE=${DEPLLOGDIR}/bin/log/$(hostname).svn_promotion.$(date +"yyyyMMdd").log
svn status ${TRAF_DIR} |tee -a ${LOG_FILE}
svn up ${TRAF_DIR} |tee -a ${LOG_FILE}
chmod +r ${LOG_FILE}

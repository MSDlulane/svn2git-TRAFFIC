#!/bin/bash
TRAF_DIR=$(dirname $(dirname $0))
TRAFLOGDIR="/var/opt/mhg/log/TRAFFIC/"
DEPLLOGDIR=${TRAFLOGDIR}/deployment_logs
DEPLLOGFILE=${DEPLLOGDIR}/$(hostname).svn_promotion.$(date +%Y%m%d).log
if [ ! -d "${DEPLLOGDIR}" ]; then
	echo "Creating ${DEPLLOGDIR}..."
	mkdir -p ${DEPLLOGDIR}
fi
if [ ! -f "${DEPLLOGFILE}" ]; then
	echo "Creating ${DEPLLOGFILE}..."
	touch ${DEPLLOGFILE}
fi
echo ${TRAF_DIR}
svn status ${TRAF_DIR} |tee -a ${DEPLLOGFILE}
svn up ${TRAF_DIR} |tee -a ${DEPLLOGFILE}
chmod +r ${DEPLLOGFILE}

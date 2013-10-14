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
svn info ${TRAF_DIR} |awk "{print \"$(date +%c): \", \$0}" |tee -a ${DEPLLOGFILE}
svn status ${TRAF_DIR} |awk "{print \"$(date +%c): \", \$0}" |tee -a ${DEPLLOGFILE}
svn up ${TRAF_DIR} |awk "{print \"$(date +%c): \", \$0}" |tee -a ${DEPLLOGFILE}
chmod +r ${DEPLLOGFILE}

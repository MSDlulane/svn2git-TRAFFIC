#!/bin/bash
TRAFHOME=/opt/mhg/TRAFFIC
SSH_STR=$1
ROLLBACK_REV=$2
HOSTNAME=$(hostname)
if [ "${ROLLBACK_REV}" = "" ]; then
	echo "New config deploy..."
else
	echo "Rolling back to revision #${ROLLBACK_REV}..."
fi
${TRAFHOME}/bin/svctraf.sh
###
# The line below to updates the config:
${TRAFHOME}/bin/update_config.sh ${ROLLBACK_REV}
OIFS=${IFS}
IFS=$'\r\n'
for LINE in $(egrep '^${HOSTNAME}' ${TRAFHOME}/conf/deployment.instructions)
do
	INSTRUCTION=$(echo -n $LINE | awk '{print $3}')
	TRAFNAME=$(echo -n $LINE | awk '{print $2}')
	ISDONE="NO"
	echo "Attempting instruction \"${INSTRUCTION}\" on service \"${HOSTNAME}:${TRAFNAME}\"..."
	
	if [ "${INSTRUCTION}" = "restart" ]; then
		${TRAFHOME}/bin/svc.sh ${TRAFNAME} ${INSTRUCTION}
		ISDONE="YES"
	fi

	if [ "${INSTRUCTION}" = "start" ]; then
		${TRAFHOME}/bin/svc.sh ${TRAFNAME} ${INSTRUCTION}
		ISDONE="YES"
	fi

	if [ "${INSTRUCTION}" = "stop" ]; then
		${TRAFHOME}/bin/svc.sh ${TRAFNAME} ${INSTRUCTION}
		ISDONE="YES"
	fi

	if [ "${INSTRUCTION}" = "install" ]; then
		${TRAFHOME}/bin/svc.sh ${TRAFNAME} ${INSTRUCTION}
		ISDONE="YES"
	fi

	if [ "${INSTRUCTION}" = "uninstall" ]; then
		${TRAFHOME}/bin/svc.sh ${TRAFNAME} ${INSTRUCTION}
		ISDONE="YES"
	fi

	if [ "${ISDONE}" = "NO" ]; then
		echo "The instruction, \"${INSTRUCTION}\" is invalid and cannot be performed."
	else
		echo "The instruction, \"${INSTRUCTION}\" was successfully performed on service \"${HOSTNAME}:${TRAFNAME}\"."
	fi
done
IFS=${OIFS}
${TRAFHOME}/bin/svctraf.sh
if [ -f "$TRAFHOME/conf/backup_deployment.instructions" ]; then
	echo "Removing rollback artifacts..."
	mv "${TRAFHOME}/conf/backup_deployment.instructions" "${TRAFHOME}/conf/deployment.instructions"
fi

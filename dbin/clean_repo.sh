#!/bin/bash

trafdir=$1

if [ "${trafdir}" == "" ]; then
	echo "Please specify the \"TRAFFIC\" root directory."
	exit 1
fi

echo "Deleting pids from \"${trafdir}/dbin\" ..."
rm ${trafdir}/dbin/pids

echo "Deleting etc from \"${trafdir}\" ..."
rm ${trafdir}/etc

for hostdir in ${trafdir}/conf/*
do
	echo "Host \"${trafdir}\" ..."
	for confdir in ${hostdir}/*
	do
		echo "Config \"${confdir}\" ..."
		rm -f ${confdir}/*.out
		rm -rf ${confdir}/log
	done
done

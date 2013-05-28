#!/bin/bash
testhostname=$1
trafficdirname=$2

if [ "${testhostname}" = "" ]; then
	echo "Please specify a hostname."
	exit 1
fi
if [ "${trafficdirname}" = "" ]; then
	echo "Please specify a \"traffic_dir_name\"."
	exit 2
fi
rm -f ${trafficdirname}/etc
if [ -f ${trafficdirname}/dbin/pids ]; then
	rm ${trafficdirname}/dbin/pids
fi
ln -s ${trafficdirname}/conf/${testhostname} ${trafficdirname}/etc
for trafname in $(grep "^${testhostname}" ${trafficdirname}/conf/traffic_server_list.txt | awk '{print $2}')
do
	echo "Starting \"${trafname}\" for test..."
	${trafficdirname}/dbin/traf-debug.sh ${testhostname} ${trafficdirname} ${trafname}
done


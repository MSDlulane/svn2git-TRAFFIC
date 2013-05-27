#!/bin/bash
testhostname=$1
trafficdirname=$2

for trafname in $(grep "^${testhostname}" ${trafficdirname}/conf/traffic_server_list.txt | awk '{print $3}')
do
	echo "Starting \"${trafname}\" for test..."
	${trafficdirname}/dbin/traf-debuf.sh ${testhostname} ${trafficdirname} ${trafname}
done


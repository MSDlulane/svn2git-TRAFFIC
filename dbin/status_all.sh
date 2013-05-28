#!/bin/bash
oifs=$IFS
IFS=$'\r\n'
for process in $(cat pids)
do
	echo "-----------------------------------------"
	trafname=$(echo $process |awk '{print $1'})
	pid=$(echo $process |awk '{print $2'})
	echo "Checking: ${process}..."
	ps ${pid} |grep "com.sun.management.jmxremote.port"
	netstat -ntulp |grep "${pid}/" |awk '{print $4}'
	echo "-----------------------------------------"
done

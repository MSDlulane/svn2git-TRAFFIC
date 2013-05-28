#!/bin/bash
oifs=$IFS
IFS=$'\r\n'
for process in $(cat pids)
do
	echo "-----------------------------------------"
	trafname=$(echo $process |awk '{print $1'})
	pid=$(echo $process |awk '{print $2'})
	echo "Killing: ${process}..."
	kill -9 ${pid}
	echo "-----------------------------------------"
done
echo -n "" > pids

#!/bin/sh
#
# chkconfig: 345 99 01
# description: Starts and stops the __TRAFNAME TRAF Service.
#
# pidfile: /var/run/mhgsvc/__TRAFNAME

TRAFHOME="__TRAFHOME"
TRAFNAME="__TRAFNAME"
PROCNAME=$(basename $0)

# Source function library.
if [ -f /etc/init.d/functions ] ; then
  . /etc/init.d/functions
elif [ -f /etc/rc.d/init.d/functions ] ; then
  . /etc/rc.d/init.d/functions
else
  exit 0
fi

# Avoid using root's TMPDIR
unset TMPDIR

# Source networking configuration.
. /etc/sysconfig/network

RETVAL=0

debug() {
	echo -n $"Starting $TRAFNAME Traffic Server: "
	daemon --user=mhgsvc --check="${PROCNAME}" --pidfile="/var/run/mhgsvc/${PROCNAME}.pid" $TRAFHOME/bin/traf-debug.sh $TRAFNAME
	RETVAL=$?
	[ $RETVAL -eq 0 ] && touch /var/lock/subsys/${PROCNAME}|| \
	   RETVAL=1
	echo
	return $RETVAL
}	

start() {
	echo -n $"Starting $TRAFNAME Traffic Server: "
	daemon --user=mhgsvc --check="${PROCNAME}" --pidfile="/var/run/mhgsvc/${PROCNAME}.pid" $TRAFHOME/bin/traf.sh $TRAFNAME
	RETVAL=$?
	[ $RETVAL -eq 0 ] && touch /var/lock/subsys/${PROCNAME}|| \
	   RETVAL=1
	echo
	return $RETVAL
}	

stop() {
	echo -n $"Shutting down ${TRAFNAME} Traffic Server: "
	killproc "$0"
	RETVAL=$?
	[ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/${PROCNAME}
	echo
	return $RETVAL
}	

restart() {
	stop
	start
}	

rhstatus() {
	status $PROCNAME
	RETVAL=$?
	if [ $RETVAL -ne 0 ] ; then
		return 1
	fi
}	


case "$1" in
  start)
  	start
	;;
  stop)
  	stop
	;;
  restart)
  	restart
	;;
  status)
  	rhstatus
	;;
  debug)
  	debug
	;;
  *)
	echo $"Usage: $0 {debug|start|stop|restart|status}"
	exit 1
esac

exit $?

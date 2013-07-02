#!/bin/bash
# Copyright (c) 2013 LXC Web Panel
# All rights reserved.
#
# Author: Elie Deloumeau
#
# /etc/init.d/lwp
#
### BEGIN INIT INFO
# Provides: lwp
# Required-Start: $local_fs $network
# Required-Stop: $local_fs
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: LWP Start script
### END INIT INFO


WORK_DIR="/srv/lwp"
SCRIPT="lwp.py"
DAEMON="/usr/bin/python $WORK_DIR/$SCRIPT"
PIDFILE="/var/run/lwp.pid"
USER="root"

function start () {
	echo -n 'Starting server...'
	/sbin/start-stop-daemon --start --pidfile $PIDFILE \
		--user $USER --group $USER \
		-b --make-pidfile \
		--chuid $USER \
		--chdir $WORK_DIR \
		--exec $DAEMON
	echo 'done.'
	}

function stop () {
	echo -n 'Stopping server...'
	/sbin/start-stop-daemon --stop --pidfile $PIDFILE --signal KILL --verbose
	echo 'done.'
}


case "$1" in
	'start')
		start
		;;
	'stop')
		stop
		;;
	'restart')
		stop
		start
		;;
	*)
		echo 'Usage: /etc/init.d/lwp {start|stop|restart}'
		exit 0
		;;
esac

exit 0

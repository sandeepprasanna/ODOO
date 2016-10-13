#! /bin/sh

OPENERP_HOME="/home/administrator/second3/apps/odoo"
GEVENT_START="$OPENERP_HOME/bin/openerp-gevent -c $OPENERP_HOME/conf/openerp-server.conf --max-cron-thread 0"
GEVENT_PROGRAM="openerp-gevent"
GEVENT_STATUS=""
GEVENT_PID=""
GEVENT_STATUS=""
ERROR=0

is_service_running() {
    GEVENT_PID=`ps ax | awk '/[o]penerp-gevent / {print $1}'`
    if [ "x$GEVENT_PID" != "x" ]; then
        RUNNING=1
    else
        RUNNING=0
    fi
    return $RUNNING
}

is_gevent_running() {
    is_service_running "$GEVENT_PROGRAM"
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
        GEVENT_STATUS="openerp_gevent not running"
    else
        GEVENT_STATUS="openerp_gevent already running"
    fi
    return $RUNNING
}

start_gevent() {
    is_gevent_running
    RUNNING=$?
    if [ $RUNNING -eq 1 ]; then
        echo "$0 $ARG: openerp_gevent already running"
        exit
    fi
    if [ `id -u` != 0 ]; then
        /bin/sh -c "((cd $OPENERP_HOME && $GEVENT_START 2>&1) >/dev/null) &"
    else
        su - daemon -s /bin/sh -c "((cd $OPENERP_HOME && $GEVENT_START 2>&1) >/dev/null) &"
    fi
    sleep 20
    is_gevent_running
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
        ERROR=1
    fi

    if [ $ERROR -eq 0 ]; then
        echo "$0 $ARG: openerp_gevent started"
        sleep 2
    else
        echo "$0 $ARG: openerp_gevent could not be started"
        ERROR=3
    fi
}

stop_gevent() {
    NO_EXIT_ON_ERROR=$1
    is_gevent_running
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
        echo "$0 $ARG: $GEVENT_STATUS"
        if [ "x$NO_EXIT_ON_ERROR" != "xno_exit" ]; then
            exit
        else
            return
        fi
    fi

    kill $GEVENT_PID
    sleep 3

    is_gevent_running
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
            echo "$0 $ARG: openerp_gevent stopped"
        else
            echo "$0 $ARG: openerp_gevent could not be stopped"
            ERROR=4
    fi
}

if [ "x$1" = "xstart" ]; then
    start_gevent
elif [ "x$1" = "xstop" ]; then
    stop_gevent
elif [ "x$1" = "xstatus" ]; then
    is_gevent_running
    echo "$GEVENT_STATUS"
fi

exit $ERROR

#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
LOG_FILE_PATH=/data/log
CONF_PATH=/data/conf
TEMP_PATH=/data/tmp

check_dir () {
	# build dir
	[[ ! -d $LOG_FILE_PATH/supervisor ]] && mkdir -p $LOG_FILE_PATH/supervisor
	[[ ! -d $CONF_PATH ]] && cp -rf /root/template/conf $CONF_PATH
	[[ ! -f $CONF_PATH/supervisor_service.conf ]] && cp -f /root/template/conf/supervisor_service.conf $CONF_PATH/supervisor_service.conf
	[[ ! -d $TEMP_PATH ]] && mkdir -p $TEMP_PATH && chmod 1777 $TEMP_PATH
}

check_dir

# Forward SIGTERM to supervisord process
_term() {
	while kill -0 $child >/dev/null 2>&1
	do
		kill -TERM $child 2>/dev/null
		sleep 1
	done
}
trap _term 15
exec /usr/bin/supervisord -n &
child=$!
wait $child

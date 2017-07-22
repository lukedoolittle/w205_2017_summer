#!/bin/bash
kill "$(ps -ef | grep HiveMetaStore | awk '{print $2}' | sort | head -n1)"
/data/stop_postgres.sh
/root/stop-hadoop.sh
umount /data
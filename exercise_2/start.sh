#!/bin/bash
mount -t ext4 /dev/xvdb /data
/root/start-hadoop.sh
/data/start_postgres.sh
/data/start_metastore.sh
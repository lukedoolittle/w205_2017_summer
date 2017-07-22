#!/bin/bash
mount -t ext4 /dev/xvdb /data
/data/start_postgres.sh

pip install psycopg2==2.6.2
pip install tweepy
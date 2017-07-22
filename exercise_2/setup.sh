# mount the data directory and start postgres
mount -t ext4 /dev/xvdb /data
/data/start_postgres.sh

# install psycopg2 and tweepy
pip install psycopg2==2.6.2
pip install tweepy
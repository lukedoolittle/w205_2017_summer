from ConfigParser import SafeConfigParser
import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

def create_database(
        username,
        password):
    conn = psycopg2.connect(
        database='postgres',
        user=username,
        password=password,
        host='localhost',
        port='5432')
    try:
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cur = conn.cursor()
        cur.execute('CREATE DATABASE tcount')
        cur.close()
        conn.close()
        print('Created database tcount')
    except:
        print('Could not create tcount')

    conn = psycopg2.connect(
        database='tcount',
        user=username,
        password=password,
        host='localhost',
        port='5432')

    cur = conn.cursor()
    cur.execute('''CREATE TABLE tweetwordcount 
        (word TEXT PRIMARY KEY     NOT NULL, 
        count INT     NOT NULL);''')
    conn.commit()
    print('Created table tweetwordcount')

# get the postgres username and password from the config file
parser = SafeConfigParser()
parser.read('extweetwordcount.config')

create_database(
        parser.get('postgres', 'username'),
        parser.get('postgres', 'password'))

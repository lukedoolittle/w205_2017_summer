import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

try:
    conn = psycopg2.connect(
        database="postgres",
        user="postgres",
        password="pass",
        host="localhost",
        port="5432")
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    cur.execute('CREATE DATABASE tcount')
    print("Created database tcount")
except:
    print("Could not create tcount")
finally:
    conn.close()

try:
    conn = psycopg2.connect(
        database="postgres",
        user="postgres",
        password="pass",
        host="localhost",
        port="5432")
    cur = conn.cursor()
    cur.execute('''CREATE TABLE tweetwordcount
        (word TEXT PRIMARY KEY     NOT NULL,
        count INT     NOT NULL)''')
    conn.commit()
    print('Created table tweetwordcount')
except:
    print("Could not create tcount")
finally:
    conn.close()
    
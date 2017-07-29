import sys
from ConfigParser import SafeConfigParser
import psycopg2

parser = SafeConfigParser()
parser.read('extweetwordcount.config')

conn = psycopg2.connect(
    database="tcount",
    user=parser.get('postgres', 'username'),
    password=parser.get('postgres', 'password'),
    host="localhost",
    port="5432")

if len(sys.argv) == 2:
    n = sys.argv[1]
    cur = conn.cursor()
    sql_statement = ("SELECT word, count FROM tweetwordcount ORDER BY count desc LIMIT {0}".format(n))
    cur.execute(sql_statement)
    records = cur.fetchall()
    for rec in records:
        print("({0}: {1})".format(rec[0], rec[1]))
    conn.commit()

    conn.close()
else:
    raise ValueError

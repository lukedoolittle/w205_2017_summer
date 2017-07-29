import sys
import os
from ConfigParser import SafeConfigParser
import psycopg2

parser = SafeConfigParser()
parser.read(os.path.dirname(os.path.realpath(__file__)) + '/../extweetwordcount.config')

conn = psycopg2.connect(
    database="tcount",
    user=parser.get('postgres', 'username'),
    password=parser.get('postgres', 'password'),
    host="localhost",
    port="5432")

if len(sys.argv) == 2:
    bounds = sys.argv[1].split(",")
    cur = conn.cursor()
    cur.execute("SELECT word, count FROM tweetwordcount WHERE count >= %(lower)d and count <= %(upper)d",
                {'lower': bounds[0], 'upper': bounds[1]})
    records = cur.fetchall()
    for rec in records:
        print("({0}: {1})".format(rec[0], rec[1]))
    conn.commit()
else:
    raise ValueError()

conn.close()

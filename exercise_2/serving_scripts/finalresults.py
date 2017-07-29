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

if len(sys.argv) == 1:
    cur = conn.cursor()
    cur.execute("SELECT word, count FROM tweetwordcount ORDER BY word asc")
    records = cur.fetchall()
    for rec in records:
        print("({0}: {1})".format(rec[0], rec[1]))
    conn.commit()
elif len(sys.argv) == 2:
    word = sys.argv[1].replace("'", "''")
    cur = conn.cursor()
    cur.execute("SELECT count FROM tweetwordcount WHERE word = %(word)s", {'word': word})
    records = cur.fetchone()
    conn.commit()
    if records is None:
        count = 0
    else:
        count = records[0]
    print("Total number of occurrences of of '{0}': {1}".format(
        word,
        count))
else:
    raise ValueError()

conn.close()

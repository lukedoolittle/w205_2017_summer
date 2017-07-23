import sys
import psycopg2

conn = psycopg2.connect(
    database="tcount",
    user="postgres",
    password="pass",
    host="localhost",
    port="5432")

if len(sys.argv == 2):
    bounds = sys.argv[1].split(",")
    cur = conn.cursor()
    sql_statement = ("SELECT word, count FROM tweetwordcount WHERE count >= {0} and count <= {1}"
                     .format(
                         bounds[0],
                         bounds[1]))
    cur.execute(sql_statement)
    records = cur.fetchall()
    for rec in records:
        print("({0}: {1})\n".format(rec[0], rec[1]))
    conn.commit()
else:
    raise ValueError()

conn.close()

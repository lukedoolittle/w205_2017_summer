import psycopg2

conn = psycopg2.connect(
    database="tcount",
    user="postgres",
    password="pass",
    host="localhost",
    port="5432")

cur = conn.cursor()
cur.execute("DELETE FROM tweetwordcount")
conn.commit()

conn.close()
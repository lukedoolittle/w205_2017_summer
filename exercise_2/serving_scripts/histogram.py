import sys
import os
from ConfigParser import SafeConfigParser
import psycopg2

def get_histogram(lower_bound,
                  upper_bound,
                  username,
                  password):
    with psycopg2.connect(
        database="tcount",
        user=username,
        password=password,
        host="localhost",
        port="5432") as connection:
        with connection.cursor() as cursor:
            cursor.execute("SELECT word, count FROM tweetwordcount WHERE count >= %(lower)d and count <= %(upper)d",
                           {'lower': lower_bound,
                            'upper': upper_bound})
            records = cursor.fetchall()
            for record in records:
                print("({0}: {1})".format(record[0],
                                          record[1]))

parser = SafeConfigParser()
parser.read(os.path.dirname(os.path.realpath(__file__)) + '/../extweetwordcount.config')

if len(sys.argv) == 2:
    get_histogram(sys.argv[1].split(",")[0],
                  sys.argv[1].split(",")[1],
                  parser.get('postgres', 'username'),
                  parser.get('postgres', 'password'))
else:
    raise ValueError()

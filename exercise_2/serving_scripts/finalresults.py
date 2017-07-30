import sys
import os
from ConfigParser import SafeConfigParser
import psycopg2

def get_all_wordcounts(username,
                       password):
    with psycopg2.connect(
        database="tcount",
        user=username,
        password=password,
        host="localhost",
        port="5432") as connection:
        with connection.cursor() as cursor:
            cursor.execute("SELECT word, count FROM tweetwordcount ORDER BY word asc")
            records = cursor.fetchall()
            for record in records:
                print("({0}: {1})".format(record[0],
                                          record[1]))

def get_wordcount(word, 
                  username,
                  password):
    with psycopg2.connect(
        database="tcount",
        user=username,
        password=password,
        host="localhost",
        port="5432") as connection:
        with connection.cursor() as cursor:
            cursor.execute("SELECT count FROM tweetwordcount WHERE word = %(word)s", {'word': word})
            # we only need to fetch one here since the primary key word is unique
            records = cursor.fetchone()
            if records is None:
                count = 0
            else:
                count = records[0]
            print("Total number of occurrences of of '{0}': {1}".format(
                word,
                count))

parser = SafeConfigParser()
parser.read(os.path.dirname(os.path.realpath(__file__)) + '/../extweetwordcount.config')

if len(sys.argv) == 1:
    get_all_wordcounts(parser.get('postgres', 'username'),
                       parser.get('postgres', 'password'))
elif len(sys.argv) == 2:
    get_wordcount(sys.argv[1],
                  parser.get('postgres', 'username'),
                  parser.get('postgres', 'password'))
else:
    raise ValueError("You must pass either a word or no parameters")

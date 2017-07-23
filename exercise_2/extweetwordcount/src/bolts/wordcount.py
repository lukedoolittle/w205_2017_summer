from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()

    def process(self, tup):
        word = tup.values[0]

        # create a connection to our database
        conn = psycopg2.connect(
            database="tcount",
            user="postgres",
            password="pass",
            host="localhost",
            port="5432")

        # remove apostrophes from any words as that is problematic with sql queries
        formatted_word = word.replace("'", "")

        # check to see if there is a record in the database for the given word
        cur = conn.cursor()
        sql_statement = ("SELECT exists (SELECT 1 FROM tweetwordcount WHERE word = '{0}')"
                         .format(formatted_word))
        cur.execute(sql_statement)
        records = cur.fetchone()
        conn.commit()

        # if there is a record update it with the new word count
        # if there is not a record insert a new one with a count of 1
        if records[0]:
            sql_statement = ("UPDATE tweetwordcount SET count = count + 1 WHERE word = '{0}'"
                             .format(formatted_word))
        else:
            sql_statement = ("INSERT INTO tweetwordcount (word,count) VALUES ('{0}', 1)"
                             .format(formatted_word))

        # execute insert or update command and close the connection
        cur = conn.cursor()
        cur.execute(sql_statement)
        conn.commit()
        conn.close()

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
        
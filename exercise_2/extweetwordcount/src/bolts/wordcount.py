from __future__ import absolute_import, print_function, unicode_literals
from collections import Counter
from streamparse.bolt import Bolt
import psycopg2

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()

        # get the postgres username and password from the config file
        self.username = conf.get('username')
        self.password = conf.get('password')

        # we prepopulate the internal counts dictionary with
        # any values that already exist in the database
        conn = psycopg2.connect(
            database="tcount",
            user=self.username,
            password=self.username,
            host="localhost",
            port="5432")
        cur = conn.cursor()
        cur.execute("SELECT word, count FROM tweetwordcount")
        records = cur.fetchall()
        for rec in records:
            self.counts[rec[0]] = rec[1]
        conn.commit()

    def process(self, tup):
        word = tup.values[0]

        # create a connection to our database
        conn = psycopg2.connect(
            database="tcount",
            user=self.username,
            password=self.password,
            host="localhost",
            port="5432")

        # apostrophes must be modified to work with sql queries
        formatted_word = word.replace("'", "''")

        # check to see if there is a record in the database for the given word
        cur = conn.cursor()
        sql_statement = "SELECT exists (SELECT 1 FROM tweetwordcount WHERE word = %(word)s)"
        cur.execute(sql_statement, {'word': formatted_word})
        records = cur.fetchone()
        conn.commit()

        # if there is a record update it with the new word count
        # if there is not a record insert a new one with a count of 1
        if records[0]:
            sql_statement = "UPDATE tweetwordcount SET count = count + 1 WHERE word = %(word)s"
        else:
            sql_statement = "INSERT INTO tweetwordcount (word,count) VALUES (%(word)s, 1)"

        # execute insert or update command and close the connection
        cur = conn.cursor()
        cur.execute(sql_statement, {'word': formatted_word})
        conn.commit()
        conn.close()

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
        
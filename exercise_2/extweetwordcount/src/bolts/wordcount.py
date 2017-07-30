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
        with psycopg2.connect(
            database="tcount",
            user=self.username,
            password=self.username,
            host="localhost",
            port="5432") as connection:
            with connection.cursor() as cursor:
                cursor.execute("SELECT word, count FROM tweetwordcount")
                records = cursor.fetchall()
                for record in records:
                    self.counts[record[0]] = record[1]

    def process(self, tup):
        word = tup.values[0]

        # create a connection to our database
        with psycopg2.connect(
            database="tcount",
            user=self.username,
            password=self.password,
            host="localhost",
            port="5432") as connection:
            with connection.cursor() as cursor:
                # if there is a record update it with the new word count
                # if there is not a record insert a new one with a count of 1
                # you could query the database here for the record but using the local
                # count saves a database hit
                if self.counts[word] > 0:
                    sql_statement = "UPDATE tweetwordcount SET count = count + 1 WHERE word = %(word)s"
                else:
                    sql_statement = "INSERT INTO tweetwordcount (word,count) VALUES (%(word)s, 1)"
                cursor.execute(sql_statement,
                               {'word': word})

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
        
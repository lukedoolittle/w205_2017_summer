from __future__ import absolute_import, print_function, unicode_literals

import re
from streamparse.bolt import Bolt

################################################################################
# Function to check if the string contains only ascii chars
################################################################################
def ascii_string(string):
    return all(ord(c) < 128 for c in string)

class ParseTweet(Bolt):

    def process(self, tup):
        tweet = tup.values[0]  # extract the tweetn

        # Split the tweet into words
        words = re.split(r' |,|\.|;|\?|:|!|\(|\)|\[|\]|\n|\+|/|&', tweet.replace('&amp', '&').replace('&gt', '>').replace('&lt', '<'))

        # Filter out the hash tags, RT, @ and urls
        valid_words = []
        for word in words:

            # Filter the hash tags
            if word.startswith("#"): continue

            # Filter the user mentions
            if word.startswith("@"): continue

            # Filter out retweet tags
            if word.startswith("RT"): continue

            # Filter out the urls
            if word.startswith("http"): continue
            if word.startswith("https"): continue

            # Strip leading and lagging punctuations and
            # convert to lowercase
            aword = word.strip("~\"?><,'.:;)(!$/\\%\n\r\t+-*").lower()

            # now check if the word contains only ascii
            if len(aword) > 0 and ascii_string(word):
                valid_words.append([aword])

        if not valid_words: return

        # Emit all the words
        self.emit_many(valid_words)

        # tuple acknowledgement is handled automatically

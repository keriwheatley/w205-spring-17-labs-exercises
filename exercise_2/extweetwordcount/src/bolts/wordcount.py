from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt

# Import psycopg2 to initialize postgres
import psycopg2


class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()

    def process(self, tup):

        try:

            word = tup.values[0]
            
            # Increment the local count
            self.counts[word] += 1
            self.emit([word, self.counts[word]])

            # Connect to Tcount database
            self.conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
            self.cur = self.conn.cursor()
            
            # Create variables used for SQL statements
            word_cleaned = word.lower().replace("'","''")
            word_count = self.counts[word]
            
            # SQL to update existing counts in tweetwordcount table and insert new word counts
            sql = "UPDATE Tweetwordcount "
            sql += " SET count=%s " %(word_count)
            sql += " WHERE word='%s'; " %(word_cleaned)
            sql += " INSERT INTO Tweetwordcount (word, count) "
            sql += " SELECT '%s', %s " %(word_cleaned, word_count)
            sql += " WHERE NOT EXISTS (SELECT 1 FROM Tweetwordcount WHERE word='%s');" %(word_cleaned)
            
            # Execute SQL, commit changes, and close connection
            self.cur.execute(sql)
            self.conn.commit()
            self.conn.close()

            # Log the count - just to see the topology running
            self.log('%s: %d' % (word, self.counts[word]))

        except Exception as inst:
            
            print(inst.args)
            print(inst)

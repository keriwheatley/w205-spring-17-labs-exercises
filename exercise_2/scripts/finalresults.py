import psycopg2
import sys

def main():
  
  try:

    # Connect to the Tcount database
    conn=psycopg2.connect(database='tcount', user="postgres", password="pass", host="localhost", port="5432")
    cur=conn.cursor()

    # If there are no inputs, return all words and counts
    if len(sys.argv) == 1:

      # Execute SQL statement to get words and counts; store data in a variable
      cur.execute("SELECT word, count FROM tweetwordcount ORDER by lower(word) ASC;")
      records = cur.fetchall()

      # Print word and count data
      output = ""
      for record in records: output += "(" + record[0] + ", " + str(record[1]) + "), "
      print output[:-2]

    # If there is 1 input, return the count for that input
    elif len(sys.argv) == 2:

      # Store input data
      word = sys.argv[1].lower()
      word_cleaned = sys.argv[1].lower().replace("'","''")

      # Execute SQL statement to get word count; store data in a variable
      cur.execute("SELECT count FROM tweetwordcount WHERE word='%s';" %(word_cleaned))
      records = cur.fetchall()

      # If word exists in table then print count, otherwise print word not found
      if len(records) > 0:
        for rec in records:
          print "Total number of occurrences of \"%s\": %d" %(word, rec[0])
      else:
        print "The word \"%s\" does not exist in database." %(word)

    # If there is more than 1 input, return the following message
    else:
      print "This program only accepts no input or one word input."

    conn.commit()
    conn.close()

  except Exception as inst:
    print(inst.args)
    print(inst)
   
if __name__ == '__main__':
  main() 

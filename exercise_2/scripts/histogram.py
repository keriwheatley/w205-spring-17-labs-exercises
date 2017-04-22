import psycopg2
import sys

def main():
  
  try:

    # Connect to Tcount database
    conn=psycopg2.connect(database='tcount', user="postgres", password="pass", host="localhost", port="5432")
    cur=conn.cursor()

    # Store all program inputs in a string
    range = ""
    for args in sys.argv:
      range += str.strip(args)
    # Remove "histogram.py" from string
    range=range[12:]

    # End the program if there is more than one comma
    if range.count(",") != 1:
      print "Wrong number of commas. The program accepts this input: 1,10"
      exit()

    # Store the min and max range integers
    min_range = range.split(',')[0]
    max_range = range.split(',')[1]

    # Check if variables sumitted are actually integers
    if not min_range.isdigit() or not max_range.isdigit():
      print "One or more inputs are not integers. The program accepts this input: 1,10"
      exit()
      
    # Check for correct range
    if int(min_range) > int(max_range):
      print "Integers are out of range. The program accepts this input: 1,10"
      exit()

    # SQL statement to grab words within range
    sql = "SELECT word, count FROM tweetwordcount "
    sql += " WHERE count BETWEEN %s AND %s " %(min_range, max_range)
    sql += " ORDER by count, word;"

    # Execute SQL statement
    cur.execute(sql)
    records = cur.fetchall()

    # Print words and counts
    for rec in records:
      print("%s: %d" % (str(rec[0]), (rec[1])) )

    # Close connection
    conn.commit()
    conn.close()

  except Exception as inst:
    print(inst.args)
    print(inst)
   
if __name__ == '__main__':
  main() 

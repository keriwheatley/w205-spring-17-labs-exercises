----------------------------
- Steps to run Exercise 2
- UCB MIDS w207
- Spring 2017
- Keri Wheatley
----------------------------

Required packages:
  Apache Storm, Amazon EC2, Python, Twitter API, Streamparse, Postgres, PsycoPG, Tweepy

Instructions for environment setup:
  1. Create an EC2 instance using AMI image:
        UCB MIDS W205 EX2-FULL (ami-d4dd4ec3)
  2. Attach and mount pre-prepared EBS volume
  3. Install programs:
        pip install psycopg2
        pip install tweepy
  4. Start Postgres database:
        /data/start_postgres.sh
  5. Log into w205 user:
        su - w205
  6. Clone GitHub repository to your instance:
        git clone https://github.com/keriwheatley/w205-spring-17-labs-exercises.git
  7. Create Postgres database and table:
	psql -U postgres -c "CREATE DATABASE tcount;"
	psql -U postgres -d tcount -c "CREATE TABLE tweetwordcount (word TEXT PRIMARY KEY NOT NULL, count INT NOT NULL);"

Instructions to update Twitter credentials:
  1. Navigate to tweets.py file:
        cd w205-spring-17-labs-exercises/exercise_2/extweetwordcount/src/spouts
  2. Open the file using a file editor, such as vim, and replace these keys:
        twitter_credentials = {
          "consumer_key"        :  "<your_consumer_key>",
          "consumer_secret"     :  "<your_consumer_secret>",
          "access_token"        :  "<your_access_token>",
          "access_token_secret" :  "<your_access_token_secret>",
          }
	  
Instructions to run application:
  1. Navigate to directory:
        cd w205-spring-17-labs-exercises/exercise_2/extweetwordcount
  2. Run Storm program:
        sparse run
  3. After a few minutes, exit program:
        ctrl + c
  4. Return to main directory:
        cd ~

Instructions to run reports:
  1. Navigate to directory:
        cd w205-spring-17-labs-exercises/exercise_2/scripts
  2. Run program to return counts for all words:
        python finalresults.py
  3. Run program to return count for one word:
        python finalresults.py <word>
  4. Run program to return word counts in a specified range:
        python histogram.py <min_count> , <max_count>

Initial Conditions
* Postgres is installed and running
* Apache Storm is installed
* extweetwordcount.config file is populated with PostgreSQL credentials
* tweetwordcount.clj is populated with PostgreSQL and Twitter API credentials

Initialize the postgres database by running the setup script
      python postgres_setup.py

Run the streamparse project
      cd extweetwordcount
      sparse run

After closing the running storm instance you can observe the results
      cd ../serving_scripts
      python finalresults.py
      python histogram.py 3,8
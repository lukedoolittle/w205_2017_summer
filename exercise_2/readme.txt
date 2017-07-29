Initial Conditions
* Postgres is installed and running
* Apache Storm is installed
* extweetwordcount.config file is populated with Twitter and PostgreSQL credentials

Initialize the postgres database by running the setup script
      python postgres_setup.py

Run the streamparse project
      cd extweetwordcount
      sparse run

After closing the running storm instance you can observe the results
      cd ../serving_scripts
      python finalresults.py
      python hisogram.py 3,8
      python topn.py 20

If desired you can clean out the existing database by running reset_wordcounts.py from the utility directory
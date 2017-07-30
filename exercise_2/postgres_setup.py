from ConfigParser import SafeConfigParser
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

def create_database(username,
                    password):

    with psycopg2.connect(
        database='postgres',
        user=username,
        password=password,
        host='localhost',
        port='5432') as connection:
        connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        with connection.cursor() as cursor:
            cursor.execute('CREATE DATABASE tcount')
            print('Created database tcount')

    with psycopg2.connect(
        database='tcount',
        user=username,
        password=password,
        host='localhost',
        port='5432') as connection:
        with connection.cursor() as cursor:
            cursor.execute('''CREATE TABLE tweetwordcount 
                            (word TEXT PRIMARY KEY     NOT NULL, 
                            count INT     NOT NULL);''')
            print('Created table tweetwordcount')

# get the postgres username and password from the config file
parser = SafeConfigParser()
parser.read('extweetwordcount.config')

create_database(parser.get('postgres', 'username'),
                parser.get('postgres', 'password'))

#!/bin/bash
# install psql
sudo apt-get install postgresql-12 -y
echo "listen_addresses = '*'"  | sudo tee -a /etc/postgresql/12/main/postgresql.conf
echo "port = 5432 " | sudo tee -a /etc/postgresql/12/main/postgresql.conf
echo "host  all  all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/12/main/pg_hba.conf
sudo service postgresql restart
sudo -i -u postgres bash << EOF
psql -c 'ALTER USER postgres WITH PASSWORD $DB_PASSWORD;'
psql -c 'CREATE DATABASE WHERE NOT EXISTS $DB_NAME;'
psql -c '\c $DB_NAME;'
psql -c 'CREATE TABLE IF NOT EXISTS logging ( ID integer NOT NULL DEFAULT '1', NodeName varchar(255), AttemptCount integer, PRIMARY KEY (ID) );'
exit

#!/bin/bash
# install postgres client
sudo apt update -y
sudo apt install postgresql-client-common -y
sudo  apt install postgresql-client-12 -y

sh /home/ubuntu/ssh_logging_trace.sh
export PGPASSWORD=$3;psql --host=$2  --port=5432 --username=postgres --dbname=postgres -c "drop table logging";

export PGPASSWORD=$3;psql --host=$2  --port=5432 --username=postgres --dbname=postgres -c "CREATE TABLE IF NOT EXISTS logging ( ID SERIAL, NodeName varchar(255), AttemptCount integer, PRIMARY KEY (ID) );"
while read attemptcount node_name;
do
export PGPASSWORD=$3;psql --host=$2  --port=5432 --username=postgres --dbname=postgres -c "insert into logging(attemptcount,nodename) values ($attemptcount,'$node_name')";
done < /tmp/auth.txt
echo "Printing out the attempts"
export PGPASSWORD=$3;psql --host=$2  --port=5432 --username=postgres --dbname=postgres -c "select sum(attemptcount),nodename from logging group by nodename;"

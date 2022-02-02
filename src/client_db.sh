#!/bin/bash
# install postgres client
sudo apt update -y
sudo apt install postgresql-client-common -y
sudo  apt install postgresql-client-12 -y

node_name=`awk '{print $7}' /tmp/ssh.txt`
attemptcount=`awk '{print $1}' /tmp/ssh.txt`
export PGPASSWORD=$DB_PASSWORD;psql --host=$DB_HOST  --port=$DB_PORT --username=DB_USERNAME --dbname=DB_NAME -c "insert into logging(nodename,attemptcount) values ('$node_name','$attemptcount')";
#!/bin/bash
# install psql
sudo apt-get install postgresql-12 -y
echo "listen_addresses = '*'"  | sudo tee -a /etc/postgresql/12/main/postgresql.conf
echo "port = 5432 " | sudo tee -a /etc/postgresql/12/main/postgresql.conf
echo "host  all  all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/12/main/pg_hba.conf
sudo service postgresql restart
PASSWORD=${DB_PASSWORD}
NAME=${DB_NAME}
sudo -i -u postgres bash << EOF
psql -c "ALTER USER postgres WITH PASSWORD '$PASSWORD';"
exit

select sum(attemptcount),nodename from logging group by nodename;
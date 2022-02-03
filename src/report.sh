#!/bin/bash
# shellcheck disable=SC2120
report(host,password)
{
  echo "Connection to psql database server"
  export PGPASSWORD=$2;psql --host=$1  --port=5432 --username=postgres --dbname=postgres -c "select * from logging";
  echo "Hello"
}
report($1,$2)
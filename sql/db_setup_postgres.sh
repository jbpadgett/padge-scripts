#!/bin/sh

#debug mode
#set -x
set -o errexit -o nounset -o pipefail

# Generic postgres shell script execution
# This version uses psql as an inline command with -c

# Vars for connecting to postgres db and create app user role
# Values as variables of already exported values
DBNAME=$POSTGRES_ENV_DB || "postgres"
DBUSER=$POSTGRES_ENV_USER || "postgres"
DBPASSWORD=$POSTGRES_ENV_PASSWORD || "postgres"
DBHOST=$POSTGRES_ENV_HOSTNAME
DBPORT="5432"


#Execute the sql using psql as an inline command with -c
psql \
     -X \
     -U $DBUSER \
     -W $DBPASSWORD \
     -h $DBHOST \
     -p $DBPORT \
     -d $DBNAME \
     --echo-all \
     --set AUTOCOMMIT=off \
     --set ON_ERROR_STOP=on
     -c "CREATE ROLE foorole WITH LOGIN ENCRYPTED PASSWORD 'mySuperfoopass';"


psql_exit_status = $?

if [ $psql_exit_status != 0 ]; then
echo "psql failed running this sql script" 1>&2
exit $psql_exit_status
fi

echo "psql script success!"
exit 0





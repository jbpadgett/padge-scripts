#!/bin/sh

#debug mode
#set -x
set -o errexit -o nounset -o pipefail

# Generic postgres shell script execution
# This version uses an external sql file for sql commands

# Vars for connecting to postgres db and create app user role
# Values as variables of already exported values
DBNAME=$POSTGRES_ENV_DB || "postgres"
DBUSER=$POSTGRES_ENV_USER || "postgres"
DBPASSWORD=$POSTGRES_ENV_PASSWORD || "postgres"
DBHOST=$POSTGRES_ENV_HOSTNAME
DBPORT="5432"


#Execute the sql using psql from a file.
psql \
     -X \
     -U $DBUSER \
     -W $DBPASSWORD \
     -h $DBHOST \
     -p $DBPORT \
     -d $DBNAME \
     -f /path/to/mysqlfile.sql \
     --echo-all \
     --set AUTOCOMMIT=off \
     --set ON_ERROR_STOP=on


psql_exit_status = $?

if [ $psql_exit_status != 0 ]; then
echo "psql failed running this sql script" 1>&2
exit $psql_exit_status
fi

echo "psql script success!"
exit 0






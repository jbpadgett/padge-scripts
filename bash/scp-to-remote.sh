#!/bin/sh

#debug mode
#set -x

set -o errexit -o nounset -o pipefail

#Time
now=$(date)
nowm=$(date +%m-%d-%y_%H_%M_%S)

# Sources
mysource=$HOME/scripts/s-scp
mysource2=$mysource/backup-$nowm.tar.gz
# Destination
myremotesrv=fqdn.foo.local
mydest=d-scp/	

#scp user
scpuser=vagrant

#Logfile
logfile="scplog.log"


#Commands
echo "Please wait ..."
echo "starting scp job at: $nowm..." 2>&1 | tee -a $logfile
echo ""
echo "compressing to gzipped tar at: $nowm..." 2>&1 | tee -a $logfile
echo ""
if [ -d $mysource2 ]
  then mv $mysource2 $mysource/backup-$nowm.tar.gz
else
  tar cvzf $mysource2 $mysource
fi
echo "gzipped tar completed at: $nowm..." 2>&1 | tee -a $logfile
echo ""
echo "starting backup xfer at: $nowm..." 2>&1 | tee -a $logfile
echo ""
scp -r $mysource2 $scpuser@$myremotesrv:$mydest
echo "scp job competed on at: $nowm..." 2>&1 | tee -a $logfile













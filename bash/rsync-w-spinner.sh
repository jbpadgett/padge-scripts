#!/bin/sh

#Rync with status spinner
#An ssh public key must exist on the remote host first in authorized_keys
#eg) Use ssh-copy-id -i ~/.ssh/id_rsa.pub remote-host


#debug mode
#set -x
set -o errexit -o nounset -o pipefail


# Source
mysource=$HOME/s-rsync

# Destination
myremotesrv=fqdn.foo.com
myremoteuser=darthvader
mydest=:/$HOME/d-rsync/

# Task waiting animation spinner
# borrowed spinner function from @marascio
spinner()
{
    local pid=$1
    local delay=0.06
    local spinstr='|/-\'
	tput civis;
	# while [ -d /proc/$PID ]; do
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "  %c " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
	tput cnorm;
}


#Commands
if [ ! -d $mydest ]
then
	echo "The rsync dirs do not exist already..."	
	echo "Initial Sync, Please wait ..."
	rsync -azvh -e ssh $mysource $myremoteuser@$mydest
	echo "Rsync is complete, please have a beer!"
else	
	echo "The rsync dirs exits, we will update it now with deltas..."
	echo "Please wait ..."
	rsync -azvh -e ssh $mysource $myremoteuser@$mydest #& spinner $!
	echo "Rsync is complete, please have 2 beers!"
fi




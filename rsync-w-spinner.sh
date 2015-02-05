#!/bin/sh

#Rync with status spinner

#debug mode
#set -x
set -o errexit -o nounset -o pipefail


# Source
mysource=$HOME/s-rsync

# Destination
myremotesrv=fqdn.foo.com
mydest=$myremotesrv/$HOME/d-rsync/	

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
if [ ! -f $mydest ]
then
	echo "The rsync dirs do not exist already..."	
	echo "Please wait ..."
	rsync -azvh $mysource $mydest & spinner $!
	echo "Rsync is complete, please have a beer!"
else	
	echo "The rsync dirs exits, we will update it now with deltas..."
	echo "Please wait ..."
	rsync -azvh $mysource $mydest & spinner $!
	echo "Rsync is complete, please have 2 beers!"
fi




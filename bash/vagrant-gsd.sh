#!/bin/sh

#debug mode
#set -x
set -o errexit -o nounset -o pipefail

# automate killing each vagrant VM or container locally
# assumes awk output of specific line counts which can be tweaked as needed

function arrayElementcheck() {
	myelements=${1}
	myelement=${2}
	for i in ${myelements[@]} ;
	do
		if [ $i == $myelement ] ;
		then
			return 1
		fi
	done
	return 0
}

# I have a separate vagrant scripts directory, so I get back up one dir
cd ..
vgs=$(vagrant global-status | awk 'NR==3, NR==5 {print $1}')

if arrayElementcheck $vgs There || you || started
then
	echo "All containers and host vm deleted!"
else
	for i in $vgs 
	#do echo "vagrant destroy $i"
	do yes | vagrant destroy --force $i
	done
fi

vagrant global-status







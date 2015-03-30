#!/bin/sh

#debug mode
#set -x
set -o errexit -o nounset -o pipefail

# automate killing each vagrant VM or container
# assumes awk output of specific line counts which can be tweaked as needed

vgs=$(vagrant global-status | awk 'NR==3, NR==5 {print $1}')
for i in $vgs 
#do echo "vagrant destroy $i"
do yes | vagrant destroy --force $i
done









#!/bin/sh

#debug mode
#set -x
set -o errexit -o nounset -o pipefail

# automate killing each vagrant VM or container locally
# assumes awk output of specific line counts which can be tweaked as needed.


cd ..
vgs=$(vagrant global-status | awk 'NR==3, NR==5 {print $1}')

for i in $vgs
do 
if [[ $vgs =~ "There" ]]
	then
		echo "==> All containers and the host vm deleted!"
	else
		echo "==> The following containers and VMs will be deleted now!"
		echo $vgs
		yes | vagrant destroy --force $i
fi
done
echo "==> Final output of vagrant global-status..."
vagrant global-status







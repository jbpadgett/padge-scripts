#!/bin/sh

#debug mode
#set -x
#set -o errexit -o nounset -o pipefail
set -o errexit -o nounset

# automate killing each docker container locally
# assumes awk output of specific line counts which can be tweaked as needed.
# Assumes you are on the dockerhost console/ssh

dpsd=$(docker ps -a | awk '{print $1}')

for i in $dpsd
 do docker stop $i && docker rm $i
done

echo "All containers stopped and filesystems deleted...."
echo $dpsd









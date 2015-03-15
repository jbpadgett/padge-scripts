#!/bin/sh

#debug mode
#set -x
set -o errexit -o nounset -o pipefail

# automate cleanup of docker cruft on the node running docker
# for vagrant this is typically the vagrant docker host VM

drmi=$(docker images -a | grep "^<none>" | awk '{print $3}')
drm=$(docker ps -a -q)

#delete untagged docker images
for i in $drmi
do docker rmi $i
docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}')
done

#delete stopped containers
for i in $drm
do docker rm $i
done






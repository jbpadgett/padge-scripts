#!/bin/sh
# sar io report over range of time on el distros
# view the output in ksar for nice graphs
now=$(date +"%F")
home=$(echo $HOME)

# get range of sar file names
for i in $(ls /var/log/sa | grep sar)
do
	cat $i >> $home/sariorpt$now.txt
done

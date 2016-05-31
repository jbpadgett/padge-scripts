###########################
# Shell script one liners #
###########################


#Try to connect to DB server(s) using netcat with timeout of 1
for i in mydbserver0{1,2,3}; do nc -vzw1 $i 3306; done


# Arping uses arp to find nodes on network for network troubleshooting
arping -w1 -I eth0 myserver001.foo.bar
arping -w1 -I en0 192.168.1.100


# Ping checks for mutiple IPs via for loop
for i in 10.10.10.{100,101,102} ; do ping -c1 -W1 $i >& /dev/null && echo $i RESPONDING || echo $i NO RESPONSE ; done

# Ping checks echo'd per Ip
sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 ips.txt | while read i ; do ping -c1 -W1 $i >& /dev/null && echo $i RESPONDING || echo $i NOT RESPONDING ; done

# Nmap approach is usually best
nmap -sP -PE 10.10.10.1-254 > ~/pingsweep1.txt


#Recursive Git Pull of all subdirectories in parent
# via http://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
find . -name ".git" -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} pull


# Grafana + influxdb + shell to grab stats (using influx as raw event store)
curl -G 'http://mygrafana.db.bar:8086/mychecks/series?u=root&p=root&pretty=true' --data-urlencode "q=select * from my_process where result =~ /error/ and time > now() - 2h limit 1000" ; echo


# Grab the IP of a running docker container from the docker host
 CONTAINER=$(docker ps | awk 'NR==2, NR==5 {print $1}') && docker inspect $CONTAINER | grep IPAddress | awk '{ print $2 }' | tr -d ',"'


# List and then stop and remove residual filesystems for docker containers on a dockerhost
dpsd=$(docker ps -a | awk '{print $1}'); for i in $dpsd; do docker stop $i && docker rm $i; done; echo "Containers stopped & fs deleted for..."; echo $dpsd;


# Remove a problem key from known_hosts file (line number reported in error)
sed -i 18 d .ssh/known_hosts

#The one-liner does this by passing commands to vi:
#18 d -- delete line 18
#wq -- save the file and exit

#or this one liner works also:
ssh-keygen -R <hostname>

#Find and list disk usage in the current directory sorted in decreasing order
du -s * | sort -rn | cut -f2 | xargs -d '\n' du -sh



#Find out Top 10 Largest Files or Directories 
du -sk /var/log/* | sort -r -n | head -10


#Find List of Unique Words in a file 
tr -c a-zA-Z '\n' < Readme1.txt  | sed '/^$/d' | sort | uniq -i -c


#Display Username and UID sorted by UID 
cut -d ':' -f 1,3 /etc/passwd | sort -t ':' -k2n - | tr ':' '\t'


#Find recent logs that contain the string "Exception" 
find . -name '*.log' -mtime -2 -exec grep -Hc MyException {} \; | grep -v :0$


#Displays the quantity of connections to port 80 on a per IP basis (per bashoneliners.com)
# Uses an infinite loop to display output from netstat, reformatted with grep, awk, and cut piped into uniq to provide the count. Complete with a pretty header. Polls every 5 seconds
$ clear;while x=0; do clear;date;echo "";echo "  [Count] | [IP ADDR]";echo "-------------------";netstat -np|grep :80|grep -v LISTEN|awk '{print $5}'|cut -d: -f1|uniq -c; sleep 5;done


#Converts all PNG image files in current directory to PDF using ImageMagick
for i in $(find *.PNG); do convert "$i" "`basename $i .PNG`.pdf"; done






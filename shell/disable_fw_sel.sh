#!/bin/bash
#Shell script to disable iptables and SELINUX for testing purposes.
#Disable the firewall for this session
echo "Disabling iptables firewall..."
service iptables stop
service iptables off
echo "Done. iptables disabled."

#Disable SELINUX for this session (won't persist on reboot)
echo "Disable SELINUX for this session..."
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux && cat /etc/sysconfig/selinux

echo "Done. SELINUX disabled"
echo "Verify this by running getenforce..."
getenforce

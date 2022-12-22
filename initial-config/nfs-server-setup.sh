#!/bin/bash

echo "* Install nfs-server packages ..."
apt-get update -y
apt-get install -y nfs-kernel-server rpcbind

# 
#  echo "* Install ufw ..."
#  apt-get install -y uwf
#

echo "* Create shared directory ..."
mkdir -p /nfs-storage/k8s-shared/test
mkdir -p /nfs-storage/k8s-shared/data

echo "* Generate test files ..."
echo "test file1 nfs server" > /nfs-storage/k8s-shared/test/test-nfs.txt
echo "test file2 nfs server" > /nfs-storage/k8s-shared/test/test-nfs2.txt

echo "* Change the ownership and permissions of the directory ..."
chown -R nobody:nogroup /nfs-storage
chmod -R 777 /nfs-storage

echo "* Share the directory with the hosts in the network ..."
echo "/nfs-storage/k8s-shared  192.168.1.0/24(rw,sync,no_root_squash,no_subtree_check)" | tee -a /etc/exports

echo "* Restart the nfs service and show the status ..."
systemctl restart nfs-server
systemctl status nfs-server

#
#  echo "* Add SSH service to the ufw firewall rules ..."
#  ufw allow ssh
#
#  echo "* Allow block of a network to access the NFS server ..."
#  ufw allow from 192.168.1.0/24 to any port nfs
#
#  echo "* Enable the ufw firewall ..."
#  ufw enable
#









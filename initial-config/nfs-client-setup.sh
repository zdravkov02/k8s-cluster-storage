#!/bin/bash

echo "* Install nfs-common packages ..."
apt-get update -y
apt-get install -y nfs-common

echo "* Create a new directory for the mount directory ..."
mkdir -p /nfs-storage/k8s-shared

echo "* Mount the nfs directory ..."
mount 192.168.1.130:/nfs-storage/k8s-shared /nfs-storage/k8s-shared

echo "* Verify the NFS mount is successful ..."
df -h

echo "* Read test files (verify read access)..."
cat /nfs-storage/k8s-shared/test/test-nfs.txt
cat /nfs-storage/k8s-shared/test/test-nfs2.txt

echo "* Generate test files (verify write access) ..."
echo "test file1 nfs client" > /nfs-storage/k8s-shared/test/test-client.txt
echo "test file2 nfs client" > /nfs-storage/k8s-shared/test/test-client2.txt

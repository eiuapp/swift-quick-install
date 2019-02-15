#!/bin/bash

## mount disk
if [ ! -d "/srv/node/sdb" ]; then
  mkdir -p /srv/node/sdb
fi

sudo apt update && sudo apt install -y xfsprogs rsync swift swift-account swift-container swift-object
echo "/dev/sda1 /srv/node/sdb xfs noatime,nodiratime,nobarrier,logbufs=8 0 2" >> /etc/fstab
mkfs.xfs -f /dev/sda1
mount /srv/node/sdb

## copy files 
controller=192.168.0.51
scp -r ubuntu@$controller:/tmp/storage-node/ /tmp/
cp /tmp/storage-node/hosts /etc/hosts
cp /tmp/storage-node/rsync/rsync /etc/default/rsync
cp /tmp/storage-node/rsync/rsyncd.conf /etc/rsyncd.conf
cp /tmp/storage-node/swift/* /etc/swift/
grep "MANAGEMENT_INTERFACE_IP_ADDRESS" -rl /etc/rsyncd.conf | xargs sed -i "s/MANAGEMENT_INTERFACE_IP_ADDRESS/$newstoragenodeip/g"


## chown 
chown -R swift:swift /srv/node
mkdir -p /var/cache/swift
chown -R root:swift /var/cache/swift
chmod -R 775 /var/cache/swift

## chown /tmp/storage-node

chmod -R 775 /tmp/storage-node/

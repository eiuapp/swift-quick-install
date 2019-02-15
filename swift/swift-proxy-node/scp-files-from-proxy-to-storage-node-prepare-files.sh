#!/bin/bash

## scp files to storage node

## cp /etc/swift/*.ring.gz
if [ ! -d "/tmp/storage-node/swift/" ]; then
    mkdir -p /tmp/storage-node/swift/
fi
cp /etc/swift/*.ring.gz /tmp/storage-node/swift/

## /etc/swift/*.conf
cp /etc/swift/storage-node/account-server.conf /tmp/storage-node/swift/account-server.conf
cp /etc/swift/storage-node/container-server.conf /tmp/storage-node/swift/container-server.conf
cp /etc/swift/storage-node/object-server.conf /tmp/storage-node/swift/object-server.conf
cp /etc/swift/swift.conf /tmp/storage-node/swift/swift.conf
  

## /etc/rsync/rsyncd.conf
if [ ! -d "/tmp/storage-node/rsync/" ]; then
    mkdir -p /tmp/storage-node/rsync/
fi
if [ ! -f "/etc/swift/storage-node/rsyncd.conf" ]; then
    echo "/etc/swift/storage-node/rsyncd.conf 不存在，请到某个 storage node 中复制一份过来"
fi
cp /etc/swift/storage-node/rsyncd.conf /tmp/storage-node/rsync/rsyncd.conf


## hosts
if [ ! -d "/tmp/storage-node/" ]; then
    mkdir -p /tmp/storage-node/
fi
cp /etc/hosts /tmp/storage-node/

## authorized_keys
if [ ! -d "/tmp/storage-node/" ]; then
    mkdir -p /tmp/storage-node/
fi
cp /root/.ssh/authorized_keys /tmp/storage-node/

## set-access.sh
if [ ! -f "/etc/swift/storage-node/set-access.sh" ]; then
    echo "/etc/swift/storage-node/set-access.sh 不存在，请到某个 storage node 中复制一份过来"
fi
cp /etc/swift/storage-node/set-access.sh /tmp/storage-node/set-access.sh

## prerequisites.sh
if [ ! -f "/etc/swift/storage-node/prerequisites.sh" ]; then
    echo "/etc/swift/storage-node/prerequisites.sh 不存在，请到某个 storage node 中复制一份过来"
fi
cp /etc/swift/storage-node/prerequisites.sh /tmp/storage-node/prerequisites.sh
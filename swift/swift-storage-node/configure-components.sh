#!/bin/bash

## configure components

if [ ! -f ./ding-dev-storage-node-swift-conf/account-server.conf ]; then
    echo "./ding-dev-storage-node-swift-conf/account-server.conf 文件不存在, 请检查后再安装！"
    exit
fi
cp ./ding-dev-storage-node-swift-conf/account-server.conf /etc/swift/account-server.conf 

if [ ! -f ./ding-dev-storage-node-swift-conf/container-server.conf ]; then
    echo "./ding-dev-storage-node-swift-conf/container-server.conf 文件不存在, 请检查后再安装！"
    exit
fi
cp ./ding-dev-storage-node-swift-conf/container-server.conf /etc/swift/container-server.conf 

if [ ! -f ./ding-dev-storage-node-swift-conf/object-server.conf ]; then
    echo "./ding-dev-storage-node-swift-conf/object-server.conf 文件不存在, 请检查后再安装！"
    exit
fi
cp ./ding-dev-storage-node-swift-conf/object-server.conf /etc/swift/object-server.conf 

chown -R swift:swift /srv/node

if [ ! -d /var/cache/swift ]; then
    mkdir -p /var/cache/swift
fi
chown -R root:swift /var/cache/swift
chmod -R 775 /var/cache/swift
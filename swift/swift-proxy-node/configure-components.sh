#!/bin/bash

## configure components

if [ -f /etc/swift/proxy-server.conf ]; then
    rm /etc/swift/proxy-server.conf
fi

if [ ! -f ./ding-dev-proxy-node-swift-conf/proxy-server.conf ]; then
    echo "./ding-dev-proxy-node-swift-conf/proxy-server.conf, 请检查后再安装！"
fi
cp ./ding-dev-proxy-node-swift-conf/proxy-server.conf /etc/swift/proxy-server.conf 


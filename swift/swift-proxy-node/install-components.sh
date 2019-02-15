#!/bin/bash

## Install and configure components¶
apt-get install swift swift-proxy python-swiftclient   python-keystoneclient python-keystonemiddleware   memcached -y
if [ ! -d /etc/swift ]; then
    mkdir /etc/swift
fi
curl -o /etc/swift/proxy-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h=stable/queens


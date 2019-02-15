#!/bin/bash

chown -R root:swift /etc/swift
service memcached restart
service swift-proxy restart
#!/bin/bash

source admin-openrc
storage_node_ip="$1"
cd /etc/swift/

## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 

## add 
swift-ring-builder object.builder add   --region 1 --zone 1 --ip ${storage_node_ip} --port 6200 --device sdb --weight 100
swift-ring-builder container.builder add   --region 1 --zone 1 --ip ${storage_node_ip} --port 6201 --device sdb --weight 100
swift-ring-builder account.builder   add --region 1 --zone 1 --ip ${storage_node_ip} --port 6202   --device sdb --weight 100 

## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 


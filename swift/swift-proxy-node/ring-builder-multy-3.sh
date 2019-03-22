#!/bin/bash

source admin-openrc

cd /etc/swift/

## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 

## remove 
swift-ring-builder object.builder
swift-ring-builder object.builder remove --id=19
swift-ring-builder container.builder
swift-ring-builder container.builder  remove --id=19
swift-ring-builder account.builder 
swift-ring-builder account.builder remove --id=19  

## add
swift-ring-builder object.builder add   --region 1 --zone 3 --ip 192.168.14.211 --port 6200 --device sdb --weight 100
swift-ring-builder container.builder add   --region 1 --zone 3 --ip 192.168.14.211 --port 6201 --device sdb --weight 100
swift-ring-builder account.builder   add --region 1 --zone 3 --ip 192.168.14.211 --port 6202   --device sdb --weight 100


## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 
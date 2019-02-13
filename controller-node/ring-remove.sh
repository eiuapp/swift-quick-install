#!/bin/bash
source admin-openrc

cd /etc/swift/

## remove 
swift-ring-builder object.builder
swift-ring-builder object.builder remove --id=$1   
swift-ring-builder container.builder
swift-ring-builder container.builder  remove --id=$1
swift-ring-builder account.builder 
swift-ring-builder account.builder remove --id=$1   

## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 

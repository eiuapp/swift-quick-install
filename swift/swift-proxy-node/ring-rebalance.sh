#!/bin/bash
source admin-openrc

cd /etc/swift/

## rebalance
swift-ring-builder object.builder rebalance
swift-ring-builder account.builder rebalance
swift-ring-builder container.builder rebalance

## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 


#!/bin/bash

source admin-openrc

cd /etc/swift/

## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 

for storage_node_ip in `cat ./region-1-zone-1-ips.txt` 
do
    # storage_node_ip="$1"
    ## add 
    
    swift-ring-builder object.builder add   --region 1 --zone 1 --ip ${storage_node_ip} --port 6200 --device sdb --weight 100
    swift-ring-builder container.builder add   --region 1 --zone 1 --ip ${storage_node_ip} --port 6201 --device sdb --weight 100
    swift-ring-builder account.builder   add --region 1 --zone 1 --ip ${storage_node_ip} --port 6202   --device sdb --weight 100 
done


for storage_node_ip in `cat ./region-1-zone-2-ips.txt` 
do
    # storage_node_ip="$1"
    ## add 
    swift-ring-builder object.builder add   --region 1 --zone 2 --ip ${storage_node_ip} --port 6200 --device sdb --weight 100
    swift-ring-builder container.builder add   --region 1 --zone 2 --ip ${storage_node_ip} --port 6201 --device sdb --weight 100
    swift-ring-builder account.builder   add --region 1 --zone 2 --ip ${storage_node_ip} --port 6202   --device sdb --weight 100 
done

for storage_node_ip in `cat ./region-1-zone-3-ips.txt` 
do
    # storage_node_ip="$1"
    ## add 
    swift-ring-builder object.builder add   --region 1 --zone 3 --ip ${storage_node_ip} --port 6200 --device sdb --weight 100
    swift-ring-builder container.builder add   --region 1 --zone 3 --ip ${storage_node_ip} --port 6201 --device sdb --weight 100
    swift-ring-builder account.builder   add --region 1 --zone 3 --ip ${storage_node_ip} --port 6202   --device sdb --weight 100 
done

## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 
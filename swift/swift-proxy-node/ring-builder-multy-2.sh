#!/bin/bash

source admin-openrc

cd /etc/swift/

## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 

## remove
## remove 
swift-ring-builder object.builder
swift-ring-builder object.builder remove --id=6 
swift-ring-builder object.builder remove --id=8  
swift-ring-builder object.builder remove --id=14 
swift-ring-builder container.builder
swift-ring-builder container.builder  remove --id=6
swift-ring-builder container.builder  remove --id=8
swift-ring-builder container.builder  remove --id=14
swift-ring-builder account.builder 
swift-ring-builder account.builder remove --id=6   
swift-ring-builder account.builder remove --id=8   
swift-ring-builder account.builder remove --id=14   

## add
swift-ring-builder object.builder add   --region 1 --zone 1 --ip 192.168.12.145 --port 6200 --device sdb --weight 100
swift-ring-builder container.builder add   --region 1 --zone 1 --ip 192.168.12.145 --port 6201 --device sdb --weight 100
swift-ring-builder account.builder   add --region 1 --zone 1 --ip 192.168.12.145 --port 6202   --device sdb --weight 100

swift-ring-builder object.builder add   --region 1 --zone 2 --ip 192.168.13.93 --port 6200 --device sdb --weight 100
swift-ring-builder container.builder add   --region 1 --zone 2 --ip 192.168.13.93 --port 6201 --device sdb --weight 100
swift-ring-builder account.builder   add --region 1 --zone 2 --ip 192.168.13.93 --port 6202   --device sdb --weight 100
swift-ring-builder object.builder add   --region 1 --zone 2 --ip 192.168.13.253 --port 6200 --device sdb --weight 100
swift-ring-builder container.builder add   --region 1 --zone 2 --ip 192.168.13.253 --port 6201 --device sdb --weight 100
swift-ring-builder account.builder   add --region 1 --zone 2 --ip 192.168.13.253 --port 6202   --device sdb --weight 100



for storage_node_ip in `cat ./region-1-zone-4-ips.txt` 
do
    swift-ring-builder object.builder add   --region 1 --zone 4 --ip ${storage_node_ip} --port 6200 --device sdb --weight 100
    swift-ring-builder container.builder add   --region 1 --zone 4 --ip ${storage_node_ip} --port 6201 --device sdb --weight 100
    swift-ring-builder account.builder   add --region 1 --zone 4 --ip ${storage_node_ip} --port 6202   --device sdb --weight 100 
done


for storage_node_ip in `cat ./region-1-zone-5-ips.txt` 
do
    swift-ring-builder object.builder add   --region 1 --zone 5 --ip ${storage_node_ip} --port 6200 --device sdb --weight 100
    swift-ring-builder container.builder add   --region 1 --zone 5 --ip ${storage_node_ip} --port 6201 --device sdb --weight 100
    swift-ring-builder account.builder   add --region 1 --zone 5 --ip ${storage_node_ip} --port 6202   --device sdb --weight 100 
done


## check
swift-ring-builder object.builder
swift-ring-builder container.builder
swift-ring-builder account.builder 
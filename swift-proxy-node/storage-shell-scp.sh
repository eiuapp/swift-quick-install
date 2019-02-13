#!/bin/bash

## scp *.sh to storage node

for storage_node_ip in `cat ./storage-node-ip.txt`
do 
     #ssh admin@${storage_node_ip} "mkdir -p /tmp/swift-conf/storage-node/ && chmod 775 /tmp/swift-conf/storage-node/" &&  
     ssh admin@${storage_node_ip} "mkdir -p /tmp/swift-conf/storage-node/ " &&  
     scp -pr ../storage-node/swift-init.sh ../storage-node/init.sh admin@${storage_node_ip}:/tmp/swift-conf/storage-node/ 
done


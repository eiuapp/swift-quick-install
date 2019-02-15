#!/bin/bash

## scp *.ring.gz to storage node
#cd /tmp/storage-node/swift/
 
for storage_node_ip in `cat ./storage-node-ip.txt`
do 
     scp -r /tmp/storage-node/swift/account.ring.gz /tmp/storage-node/swift/container.ring.gz /tmp/storage-node/swift/object.ring.gz admin@${storage_node_ip}:/tmp/storage-node/swift/ 
done


#!/bin/bash

## scp files to storage node
 
storage_node_ip="192.168.11.116"
ssh admin@${storage_node_ip} "sudo apt install sshpass -y" && echo "hello"


     #ssh admin@${storage_node_ip} "mkdir -p /tmp/swift-conf/storage-node/ && chmod 775 /tmp/swift-conf/storage-node/" &&  
    #  scp -pr ../storage-node/swift-init.sh ../storage-node/init.sh admin@${storage_node_ip}:/tmp/swift-conf/storage-node/ 

# for storage_node_ip in `cat ./region-1-zone-1-ips.txt` 
# do
#      sshpass -p "admin" scp -r /tmp/storage-node/ admin@${storage_node_ip}:/tmp/storage-node/
# done

# for storage_node_ip in `cat ./region-1-zone-2-ips.txt` 
# do
#      sshpass -p "admin" scp -r /tmp/storage-node/ admin@${storage_node_ip}:/tmp/storage-node/
# done

# for storage_node_ip in `cat ./region-1-zone-3-ips.txt` 
# do
#      sshpass -p "admin" scp -r /tmp/storage-node/ admin@${storage_node_ip}:/tmp/storage-node/
# done

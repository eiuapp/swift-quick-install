#!/bin/bash

## check lick
# storage_node_ip="192.168.11.116"
# telnet ${storage_node_ip} 22 >/dev/null 2>&1 
# if [ $? -ne 0 ]; then
#     echo " ${storage_node_ip} 端口异常，请检查 ${storage_node_ip} 端口后，再安装！~" 
# fi

## scp files to storage node

# storage_node_ip="192.168.11.116"
# scp -r /tmp/storage-node/ admin@${storage_node_ip}:/tmp/

for storage_node_ip in `cat ./region-normal-state-ips.txt` 
do
    scp -r /tmp/storage-node/ admin@${storage_node_ip}:/tmp/
done



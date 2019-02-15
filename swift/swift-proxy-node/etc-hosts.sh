#!/bin/bash

echo "" >> /etc/hosts
echo "# storage node" >> /etc/hosts
for storage_node_ip in `cat ./region-1-zone-1-ips.txt` 
do
    echo "${storage_node_ip}  swift${storage_node_ip//./z} " >> /etc/hosts
done

for storage_node_ip in `cat ./region-1-zone-2-ips.txt` 
do
    echo "${storage_node_ip}  swift${storage_node_ip//./z} " >> /etc/hosts
done

for storage_node_ip in `cat ./region-1-zone-3-ips.txt` 
do
    echo "${storage_node_ip}  swift${storage_node_ip//./z} " >> /etc/hosts
done

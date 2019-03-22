#!/bin/bash


# storage_node_ip="192.168.11.116"
# $PWD/checklink.sh $storage_node_ip 22
for storage_node_ip in `cat ./region-normal-state-ips.txt` 
do
    echo " $storage_node_ip start "
    $PWD/checklink.sh $storage_node_ip 22
done

# for storage_node_ip in `cat ./region-1-zone-2-ips.txt` 
# do
#     echo " $storage_node_ip start "
#     $PWD/checklink.sh $storage_node_ip 22
# done

# for storage_node_ip in `cat ./region-1-zone-3-ips.txt` 
# do
#     echo " $storage_node_ip start "
#     $PWD/checklink.sh $storage_node_ip 22
# done
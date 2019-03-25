#!/bin/bash


# storage_node_ip="192.168.11.116"
# $PWD/checklink.sh $storage_node_ip 22
for storage_node_ip in `cat ./region-normal-state-ips.txt` 
do
    echo " $storage_node_ip start "
    $PWD/checklink.sh $storage_node_ip 22
    $PWD/checklink.sh $storage_node_ip 6200
    $PWD/checklink.sh $storage_node_ip 6201
    $PWD/checklink.sh $storage_node_ip 6202
done

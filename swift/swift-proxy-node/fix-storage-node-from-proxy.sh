#!/bin/bash

if [ 1 == 2 ]; then
    storage_node_ip=$1
    # storage_node_ip="192.168.11.116"
    echo " $storage_node_ip start "
    ssh admin@$storage_node_ip sudo /tmp/storage-node/fix-storage-node.sh
else
    for storage_node_ip in `cat ./region-normal-state-ips.txt`
    do
        echo " $storage_node_ip start "
        ssh admin@$storage_node_ip sudo /tmp/storage-node/fix-storage-node.sh
    done
fi
echo "done!"
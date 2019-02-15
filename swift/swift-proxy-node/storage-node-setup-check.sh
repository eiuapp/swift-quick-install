#!/bin/bash

## setup storage node

storage_node_ip="192.168.11.116"
# ssh root@${storage_node_ip} "/tmp/storage-node/prerequisites.sh" 


if [ `ssh root@${storage_node_ip} "tail -1 /root/storage-install.log"` -eq "ok" ]; then
    echo "${storage_node_ip} 安装完成" 
else 
    echo "${storage_node_ip} 安装失败，请检查后再次安装~~~"
    exit 
fi
# for storage_node_ip in `cat ./storage-node-ip.txt`
# do 
#      #ssh admin@${storage_node_ip} "mkdir -p /tmp/swift-conf/storage-node/ && chmod 775 /tmp/swift-conf/storage-node/" &&  
#      ssh admin@${storage_node_ip} "mkdir -p /tmp/swift-conf/storage-node/ " &&  
#      scp -pr ../storage-node/swift-init.sh ../storage-node/init.sh admin@${storage_node_ip}:/tmp/swift-conf/storage-node/ 
# done


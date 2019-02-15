#!/bin/bash

## setup storage node

# storage_node_ip="192.168.13.150"
# ssh root@${storage_node_ip} "cd"
# if [ $? -ne 0 ]; then
#     echo "登录 ${storage_node_ip} 失败，请检查 ${storage_node_ip} 后再继续安装！" 
#     exit 
# fi
# ssh root@${storage_node_ip} "cd && /tmp/storage-node/prerequisites.sh >> /root/storage-install.log 2>&1"
# # ssh root@${storage_node_ip} "tail -1 /root/storage-install.log"
# if [ `ssh root@${storage_node_ip} "tail -1 /root/storage-install.log"` = "ok" ]; then
#     echo "${storage_node_ip} 安装完成" 
# else 
#     echo "${storage_node_ip} 安装失败，请检查后再次安装~~~"
#     exit 
# fi

for storage_node_ip in `cat ./region-normal-state-ips.txt`
do 
    ssh root@${storage_node_ip} "cd"
    if [ $? -ne 0 ]; then
        echo "登录 ${storage_node_ip} 失败，请检查 ${storage_node_ip} 后再继续安装！" 
        exit 
    fi
    ssh root@${storage_node_ip} "cd && /tmp/storage-node/prerequisites.sh >> /root/storage-install.log 2>&1"
    if [ `ssh root@${storage_node_ip} "tail -1 /root/storage-install.log"` = "ok" ]; then
        echo "${storage_node_ip} 安装完成" 
    else 
        echo "${storage_node_ip} 安装失败，请检查后再次安装~~~"
        exit 
    fi
done



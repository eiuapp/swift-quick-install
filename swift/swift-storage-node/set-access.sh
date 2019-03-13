#!/bin/bash

## root authorized_keys
if [ ! -f /tmp/storage-node/authorized_keys ]; then
    echo "/tmp/storage-node/authorized_keys 中 文件未准备好，请检查后再继续安装！"
    exit
fi
if [ ! -d /root/.ssh/ ]; then
    mkdir -p /root/.ssh/
fi
chmod 700 /root/.ssh/
cp /tmp/storage-node/authorized_keys /root/.ssh/
chmod 644 /root/.ssh/authorized_keys
chown -R root:root /root/.ssh/

## admin authorized_keys
if [ ! -d /home/admin/ ]; then
    echo "不存在 admin 用户，请检查后再继续安装！"
    exit
fi
if [ ! -d /home/admin/.ssh/ ]; then
    mkdir -p /home/admin/.ssh/
fi
chmod 700 /home/admin/.ssh/
cp /tmp/storage-node/authorized_keys /home/admin/.ssh/
chmod 644 /home/admin/.ssh/authorized_keys
chown -R admin:admin /home/admin/.ssh/

echo "admin ALL = (root) NOPASSWD:ALL"  >> /etc/sudoers.d/admin
sudo chmod 0440 /etc/sudoers.d/admin
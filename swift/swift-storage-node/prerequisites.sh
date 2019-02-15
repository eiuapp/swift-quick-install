#!/bin/bash

## package
swift-init -h >/dev/null 2>&1 
if [ $? -eq 0 ]; then
    echo "软件包已安装！~" 
else
    sudo apt update && sudo apt install -y xfsprogs rsync swift swift-account swift-container swift-object
    swift-init -h >/dev/null 2>&1 || { echo >&2 "软件包安装失败，请检查~"; exit 1; }
    echo "~~~软件包安装完成！~~~"
fi

## mount disk
if [ ! -d "/srv/node/sdb" ]; then
    mkdir -p /srv/node/sdb
fi

grep -n "/dev/sda1" /etc/fstab
if [ $? -eq 0 ]; then
    grep -n "/dev/sda1 /srv/node/sdb" /etc/fstab
    if [ $? -eq 0 ]; then
        echo "已有/dev/sda1 /srv/node/sdb, 无须再添加。" 
    else
        echo "/dev/sda1 /srv/node/sdb xfs noatime,nodiratime,nobarrier,logbufs=8 0 2" >> /etc/fstab
    fi
else
    echo "/dev/sda1 /srv/node/sdb xfs noatime,nodiratime,nobarrier,logbufs=8 0 2" >> /etc/fstab
fi

mount | grep "/dev/sda1 on /srv/node/sdb type xfs"
if [ $? -eq 0 ]; then
    echo "已有/dev/sda1 盘，且已挂载 至 /srv/node/sdb，初始状态正常。" 
else
    
    mount | grep "/dev/sda1"
    if [ $? -eq 0 ]; then
        # echo "已有/dev/sda1 盘，且已挂载，但不是挂载 至 /srv/node/sdb。" 
        echo "已有/dev/sda1 盘，且已挂载，但不是 /srv/node/sdb/ 目录，umount!"
        umount /dev/sda1
    else
        echo " mount | grep sda1 失败，没有 /dev/sda1 盘，硬盘初始状态不正常，请检查后再继续安装！" 
        fdisk -l | grep sda1
        if [ $? -ne 0 ]; then
            echo " 没有/dev/sda1 盘，请检查后再继续安装！"
            exit
        fi
    fi
    mkfs.xfs -f /dev/sda1 # >/dev/null 2>&1 
    if [ $? -eq 0 ]; then
        echo "已有/dev/sda1 盘，且已挂载 至 /srv/node/sdb，初始状态正常。" 
    else
        echo "I require foo but it's not installed.  Aborting."
        apt-get install xfsprogs -y
        mkfs.xfs -f /dev/sda1 # >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "mkfs.xfs 失败，请检查后再继续安装！"
            exit
        fi
    fi
    mount /srv/node/sdb
fi
mount | grep "/dev/sda1 on /srv/node/sdb type xfs"
if [ $? -eq 0 ]; then
    echo "已有/dev/sda1 盘，且已挂载，初始状态正常。" 
else 
    echo "硬盘初始状态不正常，请检查后再继续安装！" 
    exit 
fi

## chown /tmp/storage-node
chmod -R 775 /tmp/storage-node/
if [ ! -d /tmp/storage-node/ ]; then
    echo "/tmp/storage-node/ 中 文件未准备好，请检查后再继续安装！"
    exit
fi

## swift 配置
if [ ! -d "/etc/swift/" ]; then
  mkdir -p /etc/swift/
fi
cd /etc/swift/
if [ ! -d /tmp/storage-node/swift/ ]; then
    echo "/tmp/storage-node/swift/ 中 文件未准备好，请检查后再继续安装！"
    exit
fi
cp /tmp/storage-node/swift/* /etc/swift/

chown -R swift:swift /srv/node
if [ ! -d /var/cache/swift ]; then
    mkdir -p /var/cache/swift
fi
chown -R root:swift /var/cache/swift
chmod -R 775 /var/cache/swift


if [ -f "/etc/rsyncd.conf" ]; then
    echo "已有/etc/rsyncd.conf，与预想初始状态不一致，请 运行后 检查！" 
    rm /etc/rsyncd.conf
    cat /tmp/storage-node/rsync/rsyncd.conf >> /etc/rsyncd.conf
else
    cat /tmp/storage-node/rsync/rsyncd.conf >> /etc/rsyncd.conf
fi

sed -i 's/^RSYNC_ENABLE=false/RSYNC_ENABLE=true/' /etc/default/rsync

## /etc/hosts
if [ ! -f /tmp/storage-node/hosts ]; then
    echo "/tmp/storage-node/hosts 中 文件未准备好，请检查后再继续安装！"
    exit
fi
cp /tmp/storage-node/hosts /etc/hosts


service rsync stop
service rsync start
service rsync status

swift-init all start
swift-init all restart
swift-init all status

echo "" 
echo "ok"
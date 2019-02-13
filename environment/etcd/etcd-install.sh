#!/bin/bash


apt install etcd -y
cat ./etcd.conf >> /etc/default/etcd 
systemctl enable etcd
systemctl start etcd

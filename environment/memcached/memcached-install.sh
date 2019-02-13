#!/bin/bash



apt install memcached python-memcache -y
vi /etc/memcached.conf 
sed -i 's/^-l 127.0.0.1/-l 0.0.0.0/g'  /etc/memcached.conf
service memcached restart

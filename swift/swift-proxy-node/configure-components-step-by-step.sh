#!/bin/bash

## Install and configure components¶

grep -c "SWIFT_PASS" -rn ./proxy-server-conf-filter-authtoken.conf
if [ $? -eq 0 ]; then
    echo "请替换SWIFT_PASS为真实密码后重试" 
    exit
else
    echo "SWIFT_PASS 已准备"
fi

sed -i 's/^# swift_dir = /swift_dir = /'  /etc/swift/proxy-server.conf
sed -i 's/^# user = /user = /'  /etc/swift/proxy-server.conf

grep -c "pipeline = authtoken keystoneauth" -rn /etc/swift/proxy-server.conf
if [ $? -eq 0 ]; then
    echo "pipeline = authtoken keystoneauth 已存在，不用添加" 
else
    sed -i 's/^pipeline = /pipeline = authtoken keystoneauth /'  /etc/swift/proxy-server.conf
fi

sed -i 's/^# account_autocreate = false/account_autocreate = true/'  /etc/swift/proxy-server.conf

grep -n '^\[filter:keystoneauth\]' /etc/swift/proxy-server.conf
if [ $? -eq 0 ]; then
    echo "默认配置中已经有了 [filter:keystoneauth]，请检查配置文件" 
else
    cat ./proxy-server-conf-filter-keystoneauth.conf >> /etc/swift/proxy-server.conf
fi
grep -n '^\[filter:authtoken\]' /etc/swift/proxy-server.conf
if [ $? -eq 0 ]; then
    echo "默认配置中已经有了 [filter:authtoken]，请检查配置文件" 
else
    cat ./proxy-server-conf-filter-authtoken.conf >> /etc/swift/proxy-server.conf
fi

sed -i 's/^# memcache_servers = 127.0.0.1:11211/memcache_servers = controller:11211/'  /etc/swift/proxy-server.conf



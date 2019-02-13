#!/bin/bash

sudo apt-get install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,arm64,i386,ppc64el] https://mirrors.shu.edu.cn/mariadb/repo/10.3/ubuntu xenial main'
apt update 
apt install mariadb-server python-pymysql -y
if [ ! -f ./99-openstack.cnf ]; then
    echo "There is not a 99-openstack.cnf file"
    exit 1
fi
cat ./99-openstack.cnf > /etc/mysql/mariadb.conf.d/99-openstack.cnf

service mysql restart

mysql_secure_installation

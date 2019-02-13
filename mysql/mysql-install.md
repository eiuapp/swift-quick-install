
安装 mysql-server

## env

- os: ubuntu 16
- mysql: 5.7

## step

因为keystone安装，需要 mysql 

https://dev.mysql.com/downloads/repo/apt/ 下载 对应 *.deb 文件 ，这里是 mysql-apt-config_0.8.12-1_all.deb


```shell
sudo dpkg -i ./mysql-apt-config_0.8.12-1_all.deb
```

选择版本，我这里是 5.7 

```shell
sudo apt-get update
sudo apt-get install mysql-server -y
mysql_secure_installation
```
## ref
- https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/
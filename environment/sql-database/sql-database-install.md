
## step

### Install and configure components

#### Install the packages
```shell
apt install mariadb-server python-pymysql
vi /etc/mysql/mariadb.conf.d/99-openstack.cnf
```

#### edit the /etc/mysql/mariadb.conf.d/99-openstack.cnf file

```text
[mysqld]
bind-address = 0.0.0.0

default-storage-engine = innodb
innodb_file_per_table = on
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8
```

### Finalize installation¶

#### Restart the database service:

```shell
service mysql restart
```

#### Secure the database service

Secure the database service by running the mysql_secure_installation script. In particular, choose a suitable password for the database root account:

```shell
mysql_secure_installation
```

## ref
- https://docs.openstack.org/install-guide/environment-sql-database-ubuntu.html
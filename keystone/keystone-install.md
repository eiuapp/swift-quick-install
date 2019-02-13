

## env

- os: ubuntu 16.04
- openstack: queen 版
- mysql: 5.7
- keystone: 

## step

### prerequsities
```shell
vi /etc/hosts
```
添加 controller 至 本机IP


```shell
sudo apt install python-pip -y
sudo pip install pymysql
```

### mysql

```mysql
CREATE DATABASE IF NOT EXISTS keystone default charset utf8 COLLATE utf8_general_ci; 
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'KEYSTONE_DBPASS';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'KEYSTONE_DBPASS';
flush privileges;
```

### Install and configure components¶


```shell
sudo apt install -y keystone  apache2 libapache2-mod-wsgi
```

#### vi /etc/keystone/keystone.conf
```shell
vi /etc/keystone/keystone.conf
```

In the [database] section, configure database access:

```text
[database]
# ...
connection = mysql+pymysql://keystone:KEYSTONE_DBPASS@controller/keystone
```

Replace KEYSTONE_DBPASS with the password you chose for the database.

In the [token] section, configure the Fernet token provider:
```text
[token]
# ...
provider = fernet
```

#### su -s /bin/sh -c "keystone-manage db_sync" keystone

```shell
su -s /bin/sh -c "keystone-manage db_sync" keystone
```

##### 报 SQL connection failed. 10 attempts left. 错了：
```shell
root@ubuntu:/home/administrator# su -s /bin/sh -c "keystone-manage db_sync" keystone
2019-02-13 10:39:34.651 21420 WARNING oslo_db.sqlalchemy.engines [-] SQL connection failed. 10 attempts left.
```

这个是连接不上了。

- controller 是否能 解析。`ping controller` 看一下，如果不能解析，请在 `/etc/hosts` 中添加。
- /etc/keystone/keystone.conf 中的 [database]下的 connection 中的 keystone 密码是否正确。

#### keystone-manage
继续

```shell
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
```

#### 
Replace ADMIN_PASS with a suitable password for an administrative user.

```shell
keystone-manage bootstrap --bootstrap-password ADMIN_PASS \
  --bootstrap-admin-url http://controller:5000/v3/ \
  --bootstrap-internal-url http://controller:5000/v3/ \
  --bootstrap-public-url http://controller:5000/v3/ \
  --bootstrap-region-id RegionOne
```


### Configure the Apache HTTP server¶

```shell
vi /etc/apache2/apache2.conf
```

Edit the /etc/apache2/apache2.conf file and configure the ServerName option to reference the controller node:

```text
ServerName controller
```
### Finalize the installation¶

#### Restart the Apache service:
```shell
service apache2 restart
```
#### Configure the administrative account

```shell
$ export OS_USERNAME=admin
$ export OS_PASSWORD=ADMIN_PASS
$ export OS_PROJECT_NAME=admin
$ export OS_USER_DOMAIN_NAME=Default
$ export OS_PROJECT_DOMAIN_NAME=Default
$ export OS_AUTH_URL=http://controller:5000/v3
$ export OS_IDENTITY_API_VERSION=3
```

Replace ADMIN_PASS with the password used in the keystone-manage bootstrap command in keystone-install-configure-ubuntu.

## ref
- https://docs.openstack.org/keystone/queens/install/keystone-install-ubuntu.html


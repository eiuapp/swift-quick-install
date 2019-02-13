
快速安装swift环境

## env

- os: ubuntu 16.04
- openstack: queen 版
- mysql: 5.7
- keystone: 
- swift: 2.7

- 系统：Ubuntu Server 16.04×64 
- 存储设置：4T
- 架构部署: 

| 主机名   |     IP      |  作用 |
|----------|:-------------:|------:|
| controller |  192.168.10.13 | controller node |
| mysql |  192.168.10.13 | 存 keystone 中用户帐户密码等数据 |
| keystone |  192.168.10.13 | auth |
| Proxy |  192.168.10.13 | swift proxy node |
| Proxy |  192.168.10.12 | swift proxy node |
| Proxy |  192.168.10.11 | swift proxy node |
| object1      |     192.168.0.127    |     存储节点1(zone1)| 
| object2      |     192.168.0.134    |     存储节点2(zone1)| 
| object3      |     192.168.0.135    |     存储节点3(zone1)| 
| object4      |    192.168.0.180     |     存储节点4(zone1)| 
| object5      |    192.168.0.189     |     存储节点5(zone1)| 

## tips

密码生成尽可能使用 `openssl rand -hex 10` 命令。但是，如果mysql中密码策略较高，要求包含 “~!@#$%” 字符，则此时，`openssl rand -hex 10`命令无效。

## step


### environment

### mysql

### keystone

### proxy node

### storage node



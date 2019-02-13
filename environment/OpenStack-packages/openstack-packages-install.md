



### Enable the Ubuntu Cloud Archive pocket as needed

OpenStack Queens for Ubuntu 16.04 LTS:

```shell
apt install software-properties-common
add-apt-repository cloud-archive:queens
```
### Finalize the installation¶

#### Upgrade the packages on all nodes:

```shell
apt update && apt dist-upgrade
```
Note

If the upgrade process includes a new kernel, reboot your host to activate it.

#### Install the OpenStack client:
```shell
apt install python-openstackclient
```
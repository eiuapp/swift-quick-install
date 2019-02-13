

## env

## step

### apt install chrony
```shell
apt install chrony
```

### edit the `/etc/chrony/chrony.conf` file:

```text
server NTP_SERVER iburst
```

Replace NTP_SERVER with the hostname or IP address of a suitable more accurate (lower stratum) NTP server. The configuration supports multiple server keys.

To enable other nodes to connect to the chrony daemon on the controller node, add this key to the same chrony.conf file mentioned above:
```text
allow 10.0.0.0/24
```
If necessary, replace 10.0.0.0/24 with a description of your subnet.

如我们可以这样设置

```text
server 192.168.10.13 iburst
allow 192.168.10.0/24
```

### Restart the NTP service:

```shell
service chrony restart
```

## ref

- https://docs.openstack.org/install-guide/environment-ntp-controller.html
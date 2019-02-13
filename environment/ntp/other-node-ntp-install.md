

## env

## step

### apt install chrony
```shell
apt install chrony
```

### edit the `/etc/chrony/chrony.conf` file:

Configure the chrony.conf file and comment out or remove all but one server key. Change it to reference the controller node.

```text
server controller iburst
```

如我们可以这样设置

```text
server controller iburst
allow 192.168.10.0/24
```

### Restart the NTP service:

```shell
service chrony restart
```

## ref

- https://docs.openstack.org/install-guide/environment-ntp-controller.html
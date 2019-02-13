

### Install and configure components¶
Install the packages:

```shell
apt install memcached python-memcache -y
```

Edit the /etc/memcached.conf file and configure the service to use the management IP address of the controller node. This is to enable access by other nodes via the management network:

```text
-l 10.0.0.11
```

Note

Change the existing line that had -l 127.0.0.1.

### Finalize installation¶
Restart the Memcached service:

```shell
service memcached restart
```
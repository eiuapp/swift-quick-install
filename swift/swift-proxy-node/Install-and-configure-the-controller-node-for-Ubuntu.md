 OpenStack Docs: Install and configure the controller node for Ubuntu

Install and configure the controller node for Ubuntu
----------------------------------------------------

updated: 2019-01-15 02:30

Install and configure the controller node for Ubuntu[¶](#install-and-configure-the-controller-node-for-ubuntu "Permalink to this headline")
===========================================================================================================================================

This section describes how to install and configure the proxy service that handles requests for the account, container, and object services operating on the storage nodes. For simplicity, this guide installs and configures the proxy service on the controller node. However, you can run the proxy service on any node with network connectivity to the storage nodes. Additionally, you can install and configure the proxy service on multiple nodes to increase performance and redundancy. For more information, see the [Deployment Guide](https://docs.openstack.org/swift/latest/deployment_guide.html).

This section applies to Ubuntu 14.04 (LTS).

Prerequisites[¶](#prerequisites "Permalink to this headline")
-------------------------------------------------------------

The proxy service relies on an authentication and authorization mechanism such as the Identity service. However, unlike other services, it also offers an internal mechanism that allows it to operate without any other OpenStack services. Before you configure the Object Storage service, you must create service credentials and an API endpoint.

Note

The Object Storage service does not use an SQL database on the controller node. Instead, it uses distributed SQLite databases on each storage node.

1.  Source the `admin` credentials to gain access to admin-only CLI commands:
    
    ```shell
    $ . admin-openrc
    ```
2.  To create the Identity service credentials, complete these steps:
    
    *   Create the `swift` user:
        
        ```shell
        $ openstack user create --domain default --password-prompt swift
        User Password:
        Repeat User Password:
        +-----------+----------------------------------+
        | Field     | Value                            |
        +-----------+----------------------------------+
        | domain\_id | default                          |
        | enabled   | True                             |
        | id        | d535e5cbd2b74ac7bfb97db9cced3ed6 |
        | name      | swift                            |
        +-----------+----------------------------------+
        ```
    *   Add the `admin` role to the `swift` user:
        
        ```shell
        $ openstack role add --project service --user swift admin
        ```
        Note
        
        This command provides no output.
        
    *   Create the `swift` service entity:
        ```shell
        $ openstack service create --name swift \
          --description "OpenStack Object Storage" object-store
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | OpenStack Object Storage         |
        | enabled     | True                             |
        | id          | 75ef509da2c340499d454ae96a2c5c34 |
        | name        | swift                            |
        | type        | object-store                     |
        +-------------+----------------------------------+
        ```
3.  Create the Object Storage service API endpoints:
    ```shell
    $ openstack endpoint create --region RegionOne \
      object-store public http://controller:8080/v1/AUTH\_%\\(project\_id\\)s
    +--------------+----------------------------------------------+
    | Field        | Value                                        |
    +--------------+----------------------------------------------+
    | enabled      | True                                         |
    | id           | 12bfd36f26694c97813f665707114e0d             |
    | interface    | public                                       |
    | region       | RegionOne                                    |
    | region\_id    | RegionOne                                    |
    | service\_id   | 75ef509da2c340499d454ae96a2c5c34             |
    | service\_name | swift                                        |
    | service\_type | object-store                                 |
    | url          | http://controller:8080/v1/AUTH\_%(project\_id)s |
    +--------------+----------------------------------------------+
    
    $ openstack endpoint create --region RegionOne \\
      object-store internal http://controller:8080/v1/AUTH\_%\\(project\_id\\)s
    +--------------+----------------------------------------------+
    | Field        | Value                                        |
    +--------------+----------------------------------------------+
    | enabled      | True                                         |
    | id           | 7a36bee6733a4b5590d74d3080ee6789             |
    | interface    | internal                                     |
    | region       | RegionOne                                    |
    | region\_id    | RegionOne                                    |
    | service\_id   | 75ef509da2c340499d454ae96a2c5c34             |
    | service\_name | swift                                        |
    | service\_type | object-store                                 |
    | url          | http://controller:8080/v1/AUTH\_%(project\_id)s |
    +--------------+----------------------------------------------+
    
    $ openstack endpoint create --region RegionOne \\
      object-store admin http://controller:8080/v1
    +--------------+----------------------------------+
    | Field        | Value                            |
    +--------------+----------------------------------+
    | enabled      | True                             |
    | id           | ebb72cd6851d4defabc0b9d71cdca69b |
    | interface    | admin                            |
    | region       | RegionOne                        |
    | region\_id    | RegionOne                        |
    | service\_id   | 75ef509da2c340499d454ae96a2c5c34 |
    | service\_name | swift                            |
    | service\_type | object-store                     |
    | url          | http://controller:8080/v1        |
    +--------------+----------------------------------+
    ```

Install and configure components[¶](#install-and-configure-components "Permalink to this headline")
---------------------------------------------------------------------------------------------------

Note

Default configuration files vary by distribution. You might need to add these sections and options rather than modifying existing sections and options. Also, an ellipsis (`...`) in the configuration snippets indicates potential default configuration options that you should retain.

1.  Install the packages:
    ```shell
    # apt-get install swift swift-proxy python-swiftclient \\
      python-keystoneclient python-keystonemiddleware \\
      memcached
    ```
    Note
    
    Complete OpenStack environments already include some of these packages.
    
    2.  Create the `/etc/swift` directory.
        
    3.  Obtain the proxy service configuration file from the Object Storage source repository:
        ```shell
        # curl -o /etc/swift/proxy-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h\=stable/queens
        ```
    4.  Edit the `/etc/swift/proxy-server.conf` file and complete the following actions:
        
        *   In the `[DEFAULT]` section, configure the bind port, user, and configuration directory:
            ```
            [DEFAULT]
            ...
            bind_port = 8080
            user = swift
            swift_dir = /etc/swift
            ```
        *   In the `[pipeline:main]` section, remove the `tempurl` and `tempauth` modules and add the `authtoken` and `keystoneauth` modules:
            ```
            [pipeline:main]
            pipeline = catch_errors gatekeeper healthcheck proxy-logging cache container_sync bulk ratelimit authtoken keystoneauth container-quotas account-quotas slo dlo versioned_writes proxy-logging proxy-server
            ```
            Note
            
            Do not change the order of the modules.
            
            Note
            
            For more information on other modules that enable additional features, see the [Deployment Guide](https://docs.openstack.org/swift/latest/deployment_guide.html).
            
        *   In the `[app:proxy-server]` section, enable automatic account creation:
            
            \[app:proxy-server\]
            use = egg:swift#proxy
            ...
            account\_autocreate = True
            
        *   In the `[filter:keystoneauth]` section, configure the operator roles:
            
            \[filter:keystoneauth\]
            use = egg:swift#keystoneauth
            ...
            operator\_roles = admin,user
            
        *   In the `[filter:authtoken]` section, configure Identity service access:
            
            \[filter:authtoken\]
            paste.filter\_factory = keystonemiddleware.auth\_token:filter\_factory
            ...
            www\_authenticate\_uri = http://controller:5000
            auth\_url = http://controller:35357
            memcached\_servers = controller:11211
            auth\_type = password
            project\_domain\_id = default
            user\_domain\_id = default
            project\_name = service
            username = swift
            password = SWIFT\_PASS
            delay\_auth\_decision = True
            
            Replace `SWIFT_PASS` with the password you chose for the `swift` user in the Identity service.
            
            Note
            
            Comment out or remove any other options in the `[filter:authtoken]` section.
            
        *   In the `[filter:cache]` section, configure the `memcached` location:
            
            \[filter:cache\]
            use = egg:swift#memcache
            ...
            memcache\_servers = controller:11211
            

updated: 2019-01-15 02:30
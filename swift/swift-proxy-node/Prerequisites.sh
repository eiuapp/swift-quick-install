#!/bin/bash

. admin-openrc
# openstack user create --domain default --password-prompt swift 
# 输入密码

openstack role add --project service --user swift admin
openstack service create --name swift   --description "OpenStack Object Storage" object-store
openstack endpoint create --region RegionOne   object-store public http://controller:8080/v1/AUTH_%\(project_id\)s
openstack endpoint create --region RegionOne   object-store internal http://controller:8080/v1/AUTH_%\(project_id\)s
openstack endpoint create --region RegionOne   object-store admin http://controller:8080/v1
#!/bin/bash


apt install rabbitmq-server -y
rabbitmqctl add_user openstack c8b970602f621fc844b8
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
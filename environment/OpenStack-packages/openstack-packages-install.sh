#!/bin/bash

apt install software-properties-common -y
add-apt-repository cloud-archive:queens
apt update  && apt dist-upgrade -y
apt install python-openstackclient -y
#!/bin/bash


apt install chrony
cat ./ntp.conf >> /etc/chrony/chrony.conf
service chrony restart
#!/bin/bash

service memcached restart
service swift-proxy restart
service memcached status
service swift-proxy status

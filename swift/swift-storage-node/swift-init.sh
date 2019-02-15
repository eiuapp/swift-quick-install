#!/bin/bash

service rsync stop
service rsync start
service rsync status
swift-init all restart
swift-init all status

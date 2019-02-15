

# Install-and-configure-the-controller-node-for-Ubuntu

## 只需要执行一次
#### Prerequisites
```
Prerequisites.sh
```

#### Install and configure components
```
install-components.sh
configure-components.sh
```

#### etc-hosts
```
etc-hosts.sh
```
## proxy node ring

#### storage ips
```
region-1-zone-1-ips.txt
region-1-zone-2-ips.txt
region-1-zone-3-ips.txt
```
#### ring-create (只需要执行一次)
```
ring-create.sh 
```
#### ring-builder (需要时执行一次)
```
ring-builder-multy.sh 
```
#### ring-rebalance (ring-builder后执行一次)
```
ring-rebalance.sh
```
#### ring-remove (需要时执行一次)
```
ring-remove.sh 
```
## 与 storage 交互

#### scp-files-from-proxy-to-storage-node-prepare-files (只需要执行一次)
```
scp-files-from-proxy-to-storage-node-prepare-files.sh
```
#### scp-files-from-proxy-to-storage-node
```
scp-files-from-proxy-to-storage-node.sh
```

这里请回 storage node 执行 set-access.sh 然后回到这里

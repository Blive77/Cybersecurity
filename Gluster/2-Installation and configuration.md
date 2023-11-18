## Download and Install

In this case i will be instaling on a cluster of 3 nodes of ubuntu 24.04.
Once you've confirmed that your system meets the necessary requirements, you can proceed with downloading and installing GlusterFS on Ubuntu 22.04. 

/etc/hosts File on the 3 Servers:
```bash
192.168.0.11 server1.local
192.168.0.21 server2.local
192.168.0.31 server3.local
```
### 1. Install GlusterFS:

Open a terminal and run the following commands:

```bash
sudo apt update
sudo apt install -y glusterfs-server
sudo systemctl enable --now glusterd
```
### Add nodes to the Gluster cluster

```bash
sudo gluster peer probe server1.local
sudo gluster peer probe server2.local
sudo gluster peer probe server3.local
```
### Configure GlusterFS Storage
It is recomended to have the volume mounted to a separate device, in this case i will be mountung to device /dev/sdb.
```bash
fdisk /dev/sdb
```
Follow this steps:
```bash
Welcome to fdisk (util-linux 2.27.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x96eae0dd.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 
First sector (2048-4194303, default 2048): 
Last sector, +sectors or +size{K,M,G,T,P} (2048-4194303, default 4194303): 

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

Now e format the created partition
```bash
sudo mkdir /data
sudo mkfs.ext4 /dev/sdb1
```
```bash
sudo nano /etc/fstab
```
Add this line:
```bash
/dev/sdb1 /glusterfs ext4 defaults 0 
```
```bash
sudo mount -a
```
### Create the Volume
The volume must be created in one of the cluster node.

This volume can be create in many diferent configurations, here are some of them with a brief explanation.

## Replicated Volume with 3 Nodes (Each Node Contains a Full Replica):

This configuration ensures that each node has a complete copy of the data for redundancy. And this is the one i used in the High availability cluster project.
```bash
sudo gluster volume create vol_replica replica 3 transport tcp \
server1.local:/data/replica \
server2.local:/data/replica \
server3.local:/data/replica \
force
```
## Distributed Volume:

Distributes data across the nodes, providing a simple way to scale capacity. Each node contributes its local storage.

```bash
sudo gluster volume create vol_distributed transport tcp \
server1.local:/data/distributed \
server2.local:/data/distributed \
server3.local:/data/distributed \
force
```

## Striped Volume:

Distributes data in stripes across nodes, improving performance by parallelizing I/O operations.

```bash
sudo gluster volume create vol_striped stripe 3 transport tcp \
server1.local:/data/striped \
server2.local:/data/striped \
server3.local:/data/striped \
force
```
## Distributed Replicated Volume:

Combines distribution and replication, distributing data across nodes while maintaining redundancy.

```bash
sudo gluster volume create vol_dist_replica replica 3 transport tcp \
server1.local:/data/dist_replica \
server2.local:/data/dist_replica \
server3.local:/data/dist_replica \
force
```
## Arbiter Volume:

Uses an arbiter server to store only file metadata, conserving storage space.

```bash
sudo gluster volume create vol_arbiter replica 2 arbiter 1 transport tcp \
server1.local:/data/arbiter \
server2.local:/data/arbiter \
server3.local:/data/arbiter \
force
```

## Distributed Striped Volume:

Combines distribution and striping, distributing striped data across nodes.

```bash
sudo gluster volume create vol_dist_striped stripe 3 transport tcp \
server1.local:/data/dist_striped \
server2.local:/data/dist_striped \
server3.local:/data/dist_striped \
force
```

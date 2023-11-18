## Download and Install

In this case i will be instaling on a cluster of 3 nodes of ubuntu 24.04.
Once you've confirmed that your system meets the necessary requirements, you can proceed with downloading and installing GlusterFS on Ubuntu 22.04. 

/etc/hosts File on the 3 Servers:
*192.168.0.11 server1.local*
*192.168.0.21 server2.local*
*192.168.0.31 server3.local*

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
### Create a Gluster Volume
It is recomended to have the volume mounted to a separate device, in this case i will be mountung to device /dev/sdb.

### Mount the device

This is done on the 3 nodes.

```bash
sudo mkdir /data
sudo parted -s /dev/sdb mklabel gpt mkpart primary ext4 0% 100%
```
Next we will use Gfs2 for a file system optimized for cluster performance.

 ```bash
sudo apt-get install gfs2-utils
sudo mkfs.gfs2 -j3 -p lock_dlm -t smbcluster:gfs2 /dev/sdb1
```

To create a volume all the following commands is inserted in one of the nodes.

## Replicated Volume with 3 Nodes (Each Node Contains a Full Replica):

This configuration ensures that each node has a complete copy of the data for redundancy.

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

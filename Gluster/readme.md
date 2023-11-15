# Introduction to GlusterFS

In the ever-evolving landscape of data management, GlusterFS emerges as a powerful and open-source distributed file system designed to seamlessly handle vast amounts of data across a network of interconnected nodes. Developed with scalability and flexibility in mind, GlusterFS simplifies the complexities of data storage and retrieval by providing a unified view of disparate storage resources.

## Key Features

1. **Scalability:** GlusterFS excels in scalability by allowing the addition of storage nodes as your data requirements grow. This ability to scale-out provides a dynamic and adaptable storage solution for both small-scale deployments and large, enterprise-level architectures.

2. **Distributed Architecture:** Built on a distributed architecture, GlusterFS distributes data across multiple nodes, eliminating the limitations of a single point of failure. This not only enhances fault tolerance but also optimizes performance by parallelizing data access.

3. **Ease of Management:** With an emphasis on user-friendliness, GlusterFS boasts a straightforward management interface. Users can easily configure and monitor storage resources, making it accessible to both seasoned system administrators and those new to distributed file systems.

4. **Redundancy and Replication:** GlusterFS provides redundancy through features like replication, ensuring data integrity and availability even in the face of hardware failures. This redundancy enhances reliability and protects against potential data loss.

5. **Open Source Community:** Being an open-source project, GlusterFS benefits from a vibrant community of developers and users. This community-driven approach fosters collaboration, innovation, and continuous improvement.

## Use Cases

- **Big Data:** GlusterFS is well-suited for managing and storing large datasets in big data environments, providing a reliable foundation for distributed storage needs.

- **Cloud Deployments:** Its scalability makes GlusterFS an excellent choice for cloud-based storage solutions, allowing organizations to expand their storage infrastructure seamlessly.

- **Media Streaming:** The distributed nature of GlusterFS makes it ideal for handling media streaming, ensuring smooth and efficient delivery of content to end-users.

In this manual, i will guide you through the process of installing, configuring, and utilizing GlusterFS to harness the full potential of distributed storage. Whether you are a system administrator, developer, or IT enthusiast, this manual aims to equip you with the knowledge and tools to effectively implement and manage GlusterFS in your environment. Let's embark on the journey of unlocking the power of scalable and distributed file storage with GlusterFS.

## System Requirements

Before initiating the installation process for GlusterFS, it is imperative to verify that your systems meet the specific hardware and software requirements outlined below:

### Hardware Requirements:

- **Storage:** Ensure an adequate amount of storage capacity on each node to accommodate your data storage needs. The actual storage requirements will depend on factors such as the volume of data, expected growth, and redundancy settings (if any).

- **Memory (RAM):** Allocate a recommended amount of RAM to each node for optimal performance. As a general guideline, a minimum of 1 GB of RAM per terabyte of data is often suggested. Adjustments may be needed based on your workload and performance expectations.

- **Processor:** GlusterFS benefits from a multicore processor for efficient parallel processing. Verify that the processors on your nodes meet or exceed the recommended specifications for GlusterFS. A modern multicore processor (e.g., dual-core or quad-core) is generally suitable.

### Software Requirements:

- **Operating System:** GlusterFS is compatible with various Linux distributions. Ensure that your nodes are running a supported version of Linux. Commonly supported distributions include CentOS, Ubuntu, Debian, and others. Refer to the GlusterFS documentation for the specific versions that are currently supported.

- **Network:** A reliable and low-latency network connection between nodes is crucial for GlusterFS performance. Confirm that your network infrastructure meets the recommended standards for communication between nodes. This includes verifying proper DNS resolution, minimal latency, and adequate bandwidth.

- **Dependencies:** Install the necessary dependencies and libraries required for GlusterFS to function correctly. These dependencies may include specific versions of software packages or libraries. Check the GlusterFS documentation for a detailed list of dependencies based on your chosen Linux distribution.

By meticulously ensuring that your systems align with these hardware and software requirements, you set the stage for a smooth installation and configuration of GlusterFS. Taking the time to meet these specifications will contribute to the stability and efficiency of your distributed file system.

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

### Add nodes to the Gluster cluster

```bash
sudo gluster peer probe server1.local
sudo gluster peer probe server2.local
sudo gluster peer probe server3.local

### Create a Gluster Volume
It is recomended to have the volume mounted to a separate device, in this case i will be mountung to device /dev/sdb.

### Mount the device

This is done on the 3 nodes.

```bash
sudo mkdir /data
sudo parted -s /dev/sdb mklabel gpt mkpart primary ext4 0% 100%

Next we will use Gfs2 for a file system optimized for cluster performance.

 ```bash
sudo apt-get install gfs2-utils
sudo mkfs.gfs2 -j3 -p lock_dlm -t smbcluster:gfs2 /dev/sdb1


To create a volume all the following commands is inserted in one of the nodes.

## Replicated Volume with 3 Nodes (Each Node Contains a Full Replica):

This configuration ensures that each node has a complete copy of the data for redundancy.

```bash
sudo gluster volume create vol_replica replica 3 transport tcp \
server1.local:/data/replica \
server2.local:/data/replica \
server3.local:/data/replica \
force

## Distributed Volume:

Distributes data across the nodes, providing a simple way to scale capacity. Each node contributes its local storage.

```bash
sudo gluster volume create vol_distributed transport tcp \
server1.local:/data/distributed \
server2.local:/data/distributed \
server3.local:/data/distributed \
force

## Striped Volume:

Distributes data in stripes across nodes, improving performance by parallelizing I/O operations.

```bash
sudo gluster volume create vol_striped stripe 3 transport tcp \
server1.local:/data/striped \
server2.local:/data/striped \
server3.local:/data/striped \
force

## Distributed Replicated Volume:

Combines distribution and replication, distributing data across nodes while maintaining redundancy.

```bash
sudo gluster volume create vol_dist_replica replica 3 transport tcp \
server1.local:/data/dist_replica \
server2.local:/data/dist_replica \
server3.local:/data/dist_replica \
force

## Arbiter Volume:

Uses an arbiter server to store only file metadata, conserving storage space.

```bash
sudo gluster volume create vol_arbiter replica 2 arbiter 1 transport tcp \
server1.local:/data/arbiter \
server2.local:/data/arbiter \
server3.local:/data/arbiter \
force

## Distributed Striped Volume:

Combines distribution and striping, distributing striped data across nodes.

```bash
sudo gluster volume create vol_dist_striped stripe 3 transport tcp \
server1.local:/data/dist_striped \
server2.local:/data/dist_striped \
server3.local:/data/dist_striped \
force

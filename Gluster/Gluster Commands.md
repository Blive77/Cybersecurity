Here's a list of some useful GlusterFS commands that can help you manage and monitor your GlusterFS cluster:

###Cluster and Volume Information:

Check if Gluster daemon is running:
```bash
gluster peer status
```

Display detailed information about all volumes:
```bash
gluster volume info
```

Check the status of a specific volume:
```bash
gluster volume status <volume_name>
```

###Volume Management:

Create a new replicated volume:
```bash
gluster volume create <volume_name> replica <replica_count> <server1:/path/to/brick> ... <serverN:/path/to/brick>
```

Start a volume:
```bash
gluster volume start <volume_name>
```
Stop a volume:
```bash
gluster volume stop <volume_name>
```

Delete a volume:
```bash
gluster volume delete <volume_name>
```

###Brick and Peer Operations:

Add a brick to a volume:
```bash
gluster volume add-brick <volume_name> replica <replica_count> <new_server:/path/to/new_brick>
```
Remove a brick from a volume:
```bash
gluster volume remove-brick <volume_name> replica <replica_count> <server:/path/to/brick>
```

Detach a peer from the cluster:
```bash
gluster peer detach <peer_hostname>
```

##Monitoring and Troubleshooting:

View the GlusterFS log:
```bash
tail -f /var/log/glusterfs/glusterd.log
```

Check the status of the glusterd service:
```bash
systemctl status glusterd
```

Check the health of the volume:
```bash
gluster volume heal <volume_name> info
```

Check for split-brain scenarios:
```bash
gluster volume heal <volume_name> split-brain
```

###Client Mounts:

Mount a GlusterFS volume on a client:
```bash
mount -t glusterfs <server:/volume_name> /mnt/mount_point
```

Unmount a GlusterFS volume:
```bash
umount /mnt/mount_point
```

Display the list of active mounts:
```bash
mount | grep gluster
```

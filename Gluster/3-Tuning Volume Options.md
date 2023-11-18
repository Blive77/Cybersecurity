# Tuning Volume Options
Adjusting volume options is a flexible process that can be done while the cluster is online and accessible.


It is advisable to enable the server.allow-insecure option to ON if your volume has numerous bricks or if there are multiple services already utilizing all the privileged ports in the system. Enabling this option allows ports to accept/reject messages from insecure ports. Only use this option if your deployment necessitates it.

To tune volume options, utilize the following command:
```bash
gluster volume set <VOLNAME>
```

For instance, to set the performance cache size for a volume named test-volume to 256MB:
```bash
gluster volume set test-volume performance.cache-size 256MB
```

The table below outlines various volume options, providing descriptions and default values:

# GlusterFS Volume Options

# GlusterFS Volume Options

| Option                             | Description                                                                                                   | Default Value                 | Available Options                                   |
|------------------------------------|---------------------------------------------------------------------------------------------------------------|-------------------------------|-----------------------------------------------------|
| auth.allow                         | IP addresses of the clients allowed to access the volume.                                                     | * (allow all)                 | Valid IP address with wildcards (e.g., 192.168.1.*) |
| auth.reject                        | IP addresses of the clients denied access to the volume.                                                       | NONE (reject none)            | Valid IP address with wildcards (e.g., 192.168.2.*) |
| client.grace-timeout               | Duration for the lock state to be maintained on the client after a network disconnection.                    | 10                            | 10 - 1800 secs                                      |
| cluster.self-heal-window-size       | Maximum number of blocks per file on which self-heal happens simultaneously.                                 | 16                            | 0 - 1025 blocks                                    |
| cluster.data-self-heal-algorithm   | Type of self-heal. "full" copies the entire file; "diff" copies out-of-sync blocks; "reset" uses a heuristic model. | reset                      | full/diff/reset                                    |
| cluster.min-free-disk              | Percentage of disk space that must be kept free.                                                             | 10%                           | Percentage of required minimum free disk space    |
| cluster.stripe-block-size           | Size of the stripe unit read from or written to.                                                             | 128 KB (for all files)        | Size in bytes                                      |
| cluster.self-heal-daemon           | Option to turn off proactive self-heal on replicated volumes.                                                 | On                            | On/Off                                              |
| cluster.ensure-durability           | Ensures data/metadata durability across abrupt brick shutdowns.                                               | On                            | On/Off                                              |
| diagnostics.brick-log-level         | Changes the log level of the bricks.                                                                         | INFO                          | DEBUG/WARNING/ERROR/CRITICAL/NONE/TRACE            |
| diagnostics.client-log-level        | Changes the log level of the clients.                                                                       | INFO                          | DEBUG/WARNING/ERROR/CRITICAL/NONE/TRACE            |
| diagnostics.latency-measurement     | Tracks statistics related to the latency of each operation.                                                    | Off                           | On/Off                                              |
| diagnostics.dump-fd-stats           | Tracks statistics related to file operations.                                                                | Off                           | On                                                 |
| features.read-only                  | Enables mounting the entire volume as read-only for all clients.                                               | Off                           | On/Off                                              |
| features.lock-heal                  | Enables self-healing of locks when the network disconnects.                                                    | On                            | On/Off                                              |
| features.quota-timeout              | Sets timeout for directory size caching in quota.                                                             | 0                             | 0 - 3600 secs                                      |
| geo-replication.indexing            | Automatically syncs filesystem changes from Master to Slave.                                                  | Off                           | On/Off                                              |
| network.frame-timeout               | Time frame after which an operation is declared dead if the server does not respond.                         | 1800 (30 mins)                | 1800 secs                                          |
| network.ping-timeout                | Duration the client waits to check server responsiveness.                                                     | 42 Secs                       | 42 Secs                                            |
| nfs.enable-ino32                    | Returns 32-bit inode numbers for 32-bit NFS clients.                                                          | Off                           | On/Off                                              |
| nfs.volume-access                   | Sets the access type for the specified sub-volume.                                                           | read-write                    | read-write/read-only                               |
| nfs.trusted-write                   | If there's an UNSTABLE write from the client, STABLE flag is returned to prevent a COMMIT request.            | Off                           | On/Off                                              |
| nfs.trusted-sync                    | Treats all writes and COMMIT requests as async.                                                              | Off                           | On/Off                                              |
| nfs.export-dir                      | Exports specified comma-separated subdirectories in the volume.                                              | No subdirectory exported      | Absolute path with allowed list of IP/hostname    |
| nfs.export-volumes                  | Enables/Disables exporting entire volumes.                                                                  | On                            | On/Off                                              |
| nfs.rpc-auth-unix                   | Enables/Disables AUTH_UNIX authentication type.                                                             | On                            | On/Off                                              |
| nfs.rpc-auth-null                   | Enables/Disables AUTH_NULL authentication type.                                                             | On                            | On/Off                                              |
| nfs.rpc-auth-allow\<IP-Addresses>    | Allows a comma-separated list of addresses and/or hostnames to connect to the server.                         | Reject All                    | IP address or Host name                             |
| nfs.rpc-auth-reject\<IP-Addresses>   | Rejects a comma-separated list of addresses and/or hostnames from connecting to the server.                   | Reject All                    | IP address or Host name                             |
| nfs.ports-insecure                  | Allows client connections from unprivileged ports.                                                           | Off                           | On/Off                                              |
| nfs.addr-namelookup                | Turns off name lookup for incoming client connections.                                                        | On                            | On/Off                                              |
| nfs.register-with-portmap           | Prevents more than one Gluster NFS server from registering with portmap service.                             | On                            | On/Off                                              |
| nfs.port \<PORT-NUMBER>              | Associates Gluster NFS with a non-default port number.                                                       | NA                            | 38465-38467                                        |
| nfs.disable                         | Turns off exporting the volume by NFS.                                                                       | Off                           | On/Off                                              |
| performance.write-behind-window-size | Size of the per-file write-behind buffer.                                                                   | 1MB                           | Write-behind cache size                            |
| performance.io-thread-count          | Number of threads in IO threads translator.                                                                 | 16                            | 0-65                                               |
| performance.flush-behind             | If set ON, instructs write-behind translator to perform flush in the background.                           | On                            | On/Off                                              |
| performance.cache-max-file-size      | Maximum file size cached by the io-cache translator.                                                         | 2 ^ 64 -1 bytes               | Size in bytes                                      |
| performance.cache-min-file-size      | Minimum file size cached by the io-cache translator.                                                         | 0B                            | Size in bytes                                      |
| performance.cache-refresh-timeout    | Retains cached data for a file till 'cache-refresh-timeout' seconds, after which data re-validation occurs. | 1s                            | 0-61 secs                                          |
| performance.cache-size               | Size of the read cache.                                                                                    | 32 MB                         | Size in bytes                                      |
| server.allow-insecure                | Allows client connections from unprivileged ports.                                                           | On                            | On/Off                                              |
| server.grace-timeout                | Duration for the lock state to be maintained on the server after a network disconnection.                  | 10                            | 10 - 1800 secs                                      |
| server.statedump-path               | Location of the state dump file.                                                                           | tmp directory of the brick    | New directory path                                 |
| storage.health-check-interval       | Seconds between health-checks on the filesystem used for the brick(s).                                      | tmp directory of the brick    | New directory path                                 |

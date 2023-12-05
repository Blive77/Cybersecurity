# UrBackup Installation and Configuration Guide

This guide outlines the installation and configuration steps for deploying UrBackup in the context of a high-availability environment with three servers running Linux 22.04. The primary focus is on Server 3, designated for all backup operations.

## UrBackup Selection

UrBackup was chosen for its comprehensive backup capabilities, emphasizing simplicity in the restoration process. All devices within this environment are equipped with the UrBackup Client, while the UrBackup Server is exclusively deployed on Server 3.

## Prepare Drive for Backups:

### Server 3

```bash
sudo nano /etc/fstab
```

Add the following at the end of the file:

```bash
/dev/sdc /backups ext4 defaults 0 0
```

```bash
sudo parted -s /dev/sdc mklabel gpt mkpart primary ext4 0% 100%
sudo mkfs.ext4 /dev/sdc
sudo mkdir /backups
sudo chmod 775 /backups
sudo mount -a
```

## UrBackup Server Installation:

### Server 3

```bash
sudo apt install curl gnupg2 software-properties-common
sudo add-apt-repository ppa:uroni/urbackup
sudo apt update
sudo apt install urbackup-server
```

During installation, choose the location as /backups.

```bash
sudo systemctl start urbackupsrv
sudo systemctl enable urbackupsrv
```

## Access the Dashboard:

Visit http://[IP-of-server]:55414

Create a new user for the UrBackup interface:

1. Navigate to http://[IP-of-server]:55414
2. Go to "Settings \ Users"
3. Add a new user for the web interface.
   - Username: admin
   - Password: 1234567

## UrBackup Client Installation:

Download UrBackup for Windows, GNU/Linux, or FreeBSD. Install the client on all servers.

### Servers 1, 2, 3

```bash
TF=$(mktemp) && wget "https://hndl.urbackup.org/Client/2.5.25/UrBackup%20Client%20Linux%202.5.25.sh" -O $TF && sudo sh $TF; rm -f $TF
```

During the client installation, choose option 1.


## Additional Configuration:

For more details, refer to [Datto Dattobd Installation](https://github.com/datto/dattobd/blob/main/INSTALL.md).

### Servers 1, 2, 3

```bash
sudo apt-key adv --fetch-keys https://cpkg.datto.com/DATTO-PKGS-GPG-KEY
echo "deb [arch=amd64] https://cpkg.datto.com/datto-deb/public/$(lsb_release -sc) $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/datto-linux-agent.list
sudo apt-get update
sudo apt-get install dattobd-dkms dattobd-utils
```

In the server dashboard, clients should now be listed.

Dropdown on the client, choose the backup type.

Wait for synchronization with the client and initiate the backup.

Ensure the specified folder has the user "urbackup" as the owner with permissions 775.

### Server 3

```bash
sudo chmod 775 /backups
sudo chown urbackup /backups
```

In settings, go to the Server menu and configure the storage path to "/backups."

After backup:

## Activating the Restore Button in UrBackup:

By default, the "Restore File" button in UrBackup is disabled for file backups. Enabling this feature adds a crucial layer of flexibility to your backup strategy, allowing you to restore files with ease.

### Server 3
```bash
sudo nano /etc/default/urbackupclient
```
Edit the file, change:
```bash
RESTORE=disabled
```
to:
```bash
RESTORE=server-confirms
```


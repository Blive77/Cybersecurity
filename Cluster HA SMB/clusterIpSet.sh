#!/bin/bash

echo "##########################################"
echo "#          Config IPs in Cluster         #"
echo "##########################################"

read -p "IP address of Server 2: " server2_ip
read -p "IP address of Server 3: " server3_ip
read -p "SSH password: " ssh_password

netplan_file="/etc/netplan/00-installer-config.yaml"

new_config_file_server1="txt/netplan.server1.txt"
new_config_file_server2="txt/netplan.server2.txt"
new_config_file_server3="txt/netplan.server3.txt"

echo "[Server2] A copiar 00-installer-config.yaml"
sshpass -p "$ssh_password" scp "$new_config_file_server2" root@"$server2_ip":"$netplan_file"
sshpass -p "$ssh_password" ssh root@"$server2_ip" 'sudo netplan apply' > /dev/null 2>&1 &
echo "[Server2] netplan apply"

echo "[Server3] A copiar 00-installer-config.yaml"
sshpass -p "$ssh_password" scp "$new_config_file_server3" root@"$server3_ip":"$netplan_file"
sshpass -p "$ssh_password" ssh root@"$server3_ip" 'sudo netplan apply' > /dev/null 2>&1 &
echo "[Server3] netplan apply"

#echo "[Server1] A copiar 00-installer-config.yaml"
sudo cp "$new_config_file_server1" "$netplan_file"
sudo netplan apply
#echo "[Server1] netplan apply"

echo "##########################################"
echo "#  IPS Updated on all nodes in cluster   #"
echo "##########################################

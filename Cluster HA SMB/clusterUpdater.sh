#!/bin/bash
echo "##########################################"
echo "#             Cluster Updater            #"
echo "##########################################"

# Directory where the text files are located
txt_dir="txt"
ssh_password="123456"
# List of server configuration files
server_files=("netplan.server1.txt" "netplan.server2.txt" "netplan.server3.txt")
server1_ips=()
server2_ips=()
server3_ips=()

for file in "${server_files[@]}"; do
  filepath="$txt_dir/$file"
  if [ -f "$filepath" ]; then
    ip_addresses=($(awk '/addresses:/{getline; print}' "$filepath" | awk '/^[[:blank:]]+-/{print $2}' | sed 's/\/24//' | grep -v '8.8.8.8'))
    case "$file" in
      "netplan.server1.txt") server1_ips=("${ip_addresses[@]}");;
      "netplan.server2.txt") server2_ips=("${ip_addresses[@]}");;
      "netplan.server3.txt") server3_ips=("${ip_addresses[@]}");;
    esac
  else
    echo "File not found: $file"
  fi
done

# Print the extracted IP addresses for each server
#echo "Server 1 IPs: ${server1_ips[@]}"
#echo "Server 2 IPs: ${server2_ips[@]}"
#echo "Server 3 IPs: ${server3_ips[@]}"

ssh-keygen -R "${server1_ips[@]}"
ssh-keygen -R "${server2_ips[@]}"
ssh-keygen -R "${server3_ips[@]}"

# Construct the command to run on the remote servers
remote_command="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y"

echo "##########################################"
echo "Server2 - ${server2_ips[@]}]           "
echo "##########################################"

output=$(sshpass -p "$ssh_password" ssh root@"${server2_ips[@]}" "$remote_command" )
echo "$output"

echo "##########################################"
echo "Server3 - ${server3_ips[@]}]           "
echo "##########################################"

output=$(sshpass -p "$ssh_password" ssh root@"${server3_ips[@]}" "$remote_command" )
echo "$output"

echo "##########################################"
echo "Server1 - ${server1_ips[@]}]           "
echo "##########################################"

output=$(sshpass -p "$ssh_password" ssh root@"${server1_ips[@]}" "$remote_command" )
echo "$output"

echo "##########################################"
echo "#        Cluster UPDATE COMPLETO         #"
echo "##########################################"







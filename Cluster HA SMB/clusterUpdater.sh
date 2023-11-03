#!/bin/bash
echo "##########################################"
echo "#             Cluster Updater            #"
echo "##########################################"

# Directory where the text files are located
txt_dir="txt"

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

echo "[Server2 ${server2_ips[@]}] A Fazer Update ao Sistema"
sshpass -p "$ssh_password" ssh root@"${server2_ips[@]}" 'sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y'

echo "[Server3 ${server3_ips[@]}] A Fazer Update ao Sistema"
sshpass -p "$ssh_password" ssh root@"${server3_ips[@]}" 'sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y'

echo "[Server1] A Fazer Update ao Sistema"
sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y

echo "##########################################"
echo "#         Cluster UDATE COMPLETO         #"
echo "##########################################"






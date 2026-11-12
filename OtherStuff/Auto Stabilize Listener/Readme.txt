# shelll
# Fabio Felgueiras 2023
#

**Reverse Shell Stabilizer Script**

This script automates the process of stabilizing a reverse shell connection, making it more interactive and user-friendly. 
It is designed for educational and ethical use, such as penetration testing and security research.


## Introduction

The `shelll` script simplifies the process of stabilizing a reverse shell connection. Once a reverse shell is established, the script performs a set of actions to make the shell more interactive and user-friendly.

## Features
- Automates the process of stabilizing a reverse shell.
- Works with various target systems.
- Enhances shell interactivity for a better user experience.

## Prerequisites
- A Linux system with `bash`.
- Basic knowledge of reverse shells and their usage.
- Proper authorization and permission to use this script on target systems.

## Preparation
1. Move it to scripts folder:  
   sudo mv shelll.sh /usr/local/bin  
2. Give execute permissions:  
   sudo chmod +x /usr/local/bin/shelll.sh
3. Create symbolic link:
   sudo ln -s /usr/local/bin/shelll.sh /usr/local/bin/shelll 

  
## Usage

1. Start the script on your local machine where you want to receive the reverse shell connection.

shelll           # Use the default port 53
shelll 5555      # Use port 5555
  

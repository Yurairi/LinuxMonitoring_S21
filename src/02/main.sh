#!/bin/bash

# Get variable values
HOSTNAME=$(hostname)
TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3, $4, $5}')
USER=$(whoami)
OS=$(lsb_release -d | cut -f2-)
DATE=$(date +"%d %b %Y %T")
UPTIME=$(uptime -p)
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
IP=$(ip -4 addr show | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1 | head -n 1)
MASK=$(ip -4 addr show | grep 'inet ' | awk '{print $2}' | cut -d'/' -f2 | head -n 1)
GATEWAY=$(ip route | grep default | awk '{print $3}')
RAM_TOTAL=$(free -h --giga | awk '/Mem:/ {print $2}')
RAM_USED=$(free -h --giga | awk '/Mem:/ {print $3}')
RAM_FREE=$(free -h --giga | awk '/Mem:/ {print $4}')
SPACE_ROOT=$(df -h / | awk '/\// {print $2}')
SPACE_ROOT_USED=$(df -h / | awk '/\// {print $3}')
SPACE_ROOT_FREE=$(df -h / | awk '/\// {print $4}')

# Display information
echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE"
echo "USER = $USER"
echo "OS = $OS"
echo "DATE = $DATE"
echo "UPTIME = $UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC"
echo "IP = $IP"
echo "MASK = $MASK"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $RAM_TOTAL"
echo "RAM_USED = $RAM_USED"
echo "RAM_FREE = $RAM_FREE"
echo "SPACE_ROOT = $SPACE_ROOT"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"

# Write data to a file if the user agrees
read -p "Do you want to save the data to a file? (Y/N): " answer
if [ "$answer" == "Y" ] || [ "$answer" == "y" ]; then
    current_time=$(date +"%d_%m_%y_%H_%M_%S")
    filename="${current_time}.status"
    
    echo -e "HOSTNAME = $HOSTNAME\nTIMEZONE = $TIMEZONE\nUSER = $USER\nOS = $OS\nDATE = $DATE\nUPTIME = $UPTIME\nUPTIME_SEC = $UPTIME_SEC\nIP = $IP\nMASK = $MASK\nGATEWAY = $GATEWAY\nRAM_TOTAL = $RAM_TOTAL\nRAM_USED = $RAM_USED\nRAM_FREE = $RAM_FREE\nSPACE_ROOT = $SPACE_ROOT\nSPACE_ROOT_USED = $SPACE_ROOT_USED\nSPACE_ROOT_FREE = $SPACE_ROOT_FREE" > "$filename"
    
    echo "Data saved to file: $filename"
fi

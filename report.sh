#!/bin/bash

echo "" > report.txt

{ 
date; 
echo "$USER"; 
hostname; 
hostname -I | awk '{print $1}'; 
curl -s ifconfig.me; echo "";  
# Get name and version of Linux distribution
cat /etc/*-release | grep "PRETTY_NAME" | cut -d "=" -f 2 | sed 's/"//g';
cat /etc/*-release | grep "VERSION_ID" | cut -d "=" -f 2 | sed 's/"//g';

# Get system uptime
uptime -p;

# Get used and free space in / in GB
df -h / | awk 'NR==2 {print $3}'; 
df -h / | awk 'NR==2 {print $4}'; 

# Get total and free RAM
free -h | awk 'NR==2 {print $2}'; 
free -h | awk 'NR==2 {print $4}';

# Get number and frequency of CPU cores
grep -m 1 "cpu cores" < /proc/cpuinfo | cut -d ":" -f 2 | xargs;
grep -m 1 "cpu MHz" < /proc/cpuinfo | cut -d ":" -f 2 | xargs; 
} >> report.txt

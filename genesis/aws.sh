#!/bin/bash

# Update and upgrade
apt update
apt upgrade -y

# Create dx directory
mkdir -p /dx

# Download necessary files
curl -fsSL -o "/dx/docker.sh" "https://get.docker.com"
curl -fsSL -o "/dx/startup.sh" "https://raw.githubusercontent.com/diphyx/dxflow/main/startup.sh"
curl -fsSL -o "/dx/docker-compose.yaml" "https://raw.githubusercontent.com/diphyx/dxflow/main/docker-compose.yaml"

# Create empty files
touch /dx/variables.env
touch /dx/packages.txt
touch /dx/script.sh
touch /dx/flow.yaml

# Install docker
sh /dx/docker.sh

# Install necessary packages
apt install -y xfsprogs sysstat

# Pull necessary docker images
docker pull dxflow/redis
docker pull dxflow/alpine
docker pull dxflow/syslog
docker pull dxflow/api
docker pull dxflow/ext-proxy
docker pull dxflow/ext-storage
docker pull dxflow/ext-sync
docker pull dxflow/ext-alarm
docker pull dxflow/ext-terminal
docker pull dxflow/ext-orchestrator

# Clean package cache
apt clean

# Remove temporary files
rm -rf /tmp/* /var/tmp/*

# Clear logs
find /var/log -type f -exec truncate -s 0 {} \;

# Remove ssh keys
rm -f /etc/ssh/ssh_host_*

# Clear history
cat /dev/null > /home/ubuntu/.bash_history
cat /dev/null > /root/.bash_history

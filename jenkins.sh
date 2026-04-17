#!/bin/bash

# for logging
exec > /var/log/user-data.log 2>&1
set -x

# Try disk resize but don't stop script
growpart /dev/nvme0n1 4 || true
lvextend -L +10G /dev/mapper/RootVG-varVol || true
lvextend -L +10G /dev/mapper/RootVG-rootVol || true
lvextend -l +100%FREE /dev/mapper/RootVG-homeVol || true

xfs_growfs / || true
xfs_growfs /var || true
xfs_growfs /home || true

# jenkins install
curl -L -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# install java
yum install fontconfig java-21-openjdk -y

# install jenkins
yum install jenkins -y

# start jenkins
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
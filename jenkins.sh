#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x

sleep 30
# Try disk resize but don't stop script
growpart /dev/nvme0n1 4 
lvextend -L +10G /dev/mapper/RootVG-varVol 
lvextend -L +10G /dev/mapper/RootVG-rootVol 
lvextend -l +100%FREE /dev/mapper/RootVG-homeVol 

xfs_growfs / 
xfs_growfs /var 
xfs_growfs /home 

# jenkins install
curl -L -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# ADD THIS 
yum clean all
yum makecache

# install java
yum install fontconfig java-21-openjdk -y

# install jenkins
yum install jenkins -y

# start jenkins
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
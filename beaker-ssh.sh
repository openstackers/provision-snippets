#!/bin/bash

# prepare ssh
echo "" | sudo tee -a /etc/ssh/sshd_config
echo "Match address 127.0.0.1" | sudo tee -a /etc/ssh/sshd_config
echo "    PermitRootLogin without-password" | sudo tee -a /etc/ssh/sshd_config
echo "" | sudo tee -a /etc/ssh/sshd_config
echo "Match address ::1" | sudo tee -a /etc/ssh/sshd_config
echo "    PermitRootLogin without-password" | sudo tee -a /etc/ssh/sshd_config
mkdir -p .ssh
ssh-keygen -f ~/.ssh/id_rsa -b 2048 -C "beaker key" -P ""
sudo mkdir -p /root/.ssh
sudo rm /root/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub | sudo tee -a /root/.ssh/authorized_keys
sudo systemctl restart sshd

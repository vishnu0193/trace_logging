#!/bin/bash
# Installing the ansible
sudo apt-get update -y
sudo apt install ansible -y
sudo apt install jq -y
sudo apt-get install sshpass -y
sudo apt-get install git -y
sudo useradd ansible -m
remote_user_pass="${ansible_user_pass}"
sudo echo "ansible:$remote_user_pass" | chpasswd
sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
sudo usermod -s /bin/bash ansible
sudo sed 's/PasswordAuthentication/#PasswordAuthentication/g' /etc/ssh/sshd_config > /tmp/ssh.txt
sudo  echo "PasswordAuthentication yes" |sudo tee -a /tmp/ssh.txt
sudo cp /tmp/ssh.txt /etc/ssh/sshd_config
sudo service ssh restart
exit
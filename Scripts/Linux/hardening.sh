#!/bin/bash

sudo useradd -r -s /bin/bash -m backupadmin
sudo usermod -aG backup backupadmin


sudo apt install -y auditd
sudo apt install -y iptables

sudo auditctl -w /etc/passwd -p wra -k passwd #Creates a watcher for /etc/passwrd

sudo auditctl -w /usr/bin/whoami -p x -k privilege_check #Check if whoami is called

sudo apt update && sudo apt upgrade -y

#/etc/ssh/sshd_config
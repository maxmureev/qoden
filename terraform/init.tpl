#!/bin/bash
echo ${hostname} > /etc/hostname
echo  '127.0.1.1  ${hostname}' >> /etc/hosts
apt-get update
apt-get -y install python
reboot

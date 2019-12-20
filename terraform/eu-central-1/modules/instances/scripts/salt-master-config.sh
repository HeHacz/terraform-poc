#!/bin/bash


sudo 'echo "auto_accept: True" >> /etc/salt/master'

systemctl restart salt-master

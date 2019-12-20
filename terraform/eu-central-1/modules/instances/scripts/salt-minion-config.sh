#!/bin/bash


echo "master: 3.120.38.160" >> /etc/salt/minion

systemctl restart salt-minion

#!/bin/bash


echo "master: "${MASTER_IP} >> /etc/salt/minion

systemctl restart salt-minion

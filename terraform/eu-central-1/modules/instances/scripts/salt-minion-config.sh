#!/bin/bash


echo "master: "${SATL_IP} >> /etc/salt/minion

systemctl restart salt-minion

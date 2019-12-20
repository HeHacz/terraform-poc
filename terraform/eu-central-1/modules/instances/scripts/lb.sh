#!/bin/bash


# echo  /etc/apache2
# echo "ProxyRequest off" > /etc/apache2/conf.d/lb.conf
# echo "ProxyRequest off" >> /etc/apache2/conf.d/lb.conf
# echo "<Proxy balancer://web >" >> /etc/apache2/conf.d/lb.conf
# echo "BalancerMember http://'${$HTTPD01IP}'" >> /etc/apache2/conf.d/lb.conf
# echo "BalancerMember http://'${$HTTPD02IP}'" >> /etc/apache2/conf.d/lb.conf
# echo "ProxySet lvmetod=byrequests" >> /etc/apache2/conf.d/lb.conf
# echo "</Proxy>" >> /etc/apache2/conf.d/lb.conf

systemctl restart apache2
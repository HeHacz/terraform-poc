#!/bin/bash


#echo  /etc/apache2
echo "ProxyRequest off\n<Proxy balancer://web >\nBalancerMember http://'${$HTTPD01_IP}'\nBalancerMember http://'${$HTTPD02_IP}'\nProxySet lvmetod=byrequests\n</Proxy>" > /etc/apache2/conf.d/lb.conf
systemclt restart apache2
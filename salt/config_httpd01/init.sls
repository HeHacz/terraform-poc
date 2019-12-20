/var/www/html/index.html:
	file.managed:
		-user: apache
		-group: apache
		-mode: 0744
		- source: salt://salt/config_httpd01/index.html
		
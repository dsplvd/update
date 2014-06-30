#!/bin/bash
output=$(sudo /opt/lampp/./ctlscript.sh status apache)
if [ "$output" == "apache already running" ]; then
	echo -e "running"
else
	sudo /opt/lampp/./lampp stop
	sudo rm /opt/lampp/logs/httpd.pid
	sudo /opt/lampp/./lampp restart && sudo /opt/lampp/./lampp restart
fi

#!/bin/bash
output=$(sudo /opt/lampp/./ctlscript.sh status apache)
if [ "$output" == "apache already running" ]
then
	exit
else
	sudo rm /opt/lampp/logs/httpd.pid
	sudo /opt/lampp/./lampp restart && sudo /opt/lampp/./lampp restart
	sudo reboot
fi

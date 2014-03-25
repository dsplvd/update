#!/bin/bash
sudo service squid3 restart
sudo pkill -9 chrome
/home/ddmallplaza/update/chromeenv.sh

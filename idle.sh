#!/bin/bash
if [[ $(xprintidle) -gt 900000 ]];
then
sudo services squid3 restart
sleep 2
sudo killall -9 google-chrome && google-chrome http://localhost/pno1 --kiosk --incognito --proxy-server=127.0.0.1:3128 --disk-cache-dir=/dev/null
fi
sleep 1
exit 1
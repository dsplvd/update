#!/bin/bash
node /home/ddmallplaza/xml2json/xml2json.js $1
sleep 5
cp /home/ddmallplaza/xml2json/$1/tiendas.json /home/ddmallplaza/mall/$2/json/tiendas.json
pm2 reload all
exit

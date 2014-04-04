#!/bin/bash
wget http://www.mallplaza.cl/xml/descuentos.php?siteid=mallplaza-$1 --output-document=descuentos.xml && sleep 10 && wget http://www.mallplaza.cl/xml/cine.php?siteid=mallplaza-$1 --output-document=cine.xml && sleep 10 && wget http://www.mallplaza.cl/xml/eventos.php?siteid=mallplaza-$1 --output-document=eventos.xml && sleep 10 && wget http://www.mallplaza.cl/xml/queestapasando.php?siteid=mallplaza-$1 --output-document=pasando.xml
sleep 5
ls pasando.xml >/dev/null || exit
./node /home/ddmallplaza/xmljson/xml2json.js $1
sleep 5
sudo service squid3 stop
sudo squid3 -k shutdown
sudo rm -rf /home/ddmallplaza/squid_cache.borrar
sudo mv /home/ddmallplaza/squid_cache.old /home/ddmallplaza/squid_cache.borrar
sudo mv /home/ddmallplaza/squid_cache /home/ddmallplaza/squid_cache.old
mkdir /home/ddmallplaza/squid_cache
sudo chown proxy:proxy /home/ddmallplaza/squid_cache
sudo squid3 -z
sudo service squid3 restart
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:3128 descuentos.xml -f //imagen
sleep 5
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:3128 cine.xml -f //afiche
sleep 5
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:8123 eventos.xml -f //afiche
sleep 5
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:3128 pasando.xml -f //imagen
cp descuentos.xml /home/ddmallplaza/mall/$2/xml/descuentos.xml
cp cine.xml /home/ddmallplaza/mall/$2/xml/cine.xml
cp eventos.xml /home/ddmallplaza/mall/$2/xml/eventos.xml
cp pasando.xml /home/ddmallplaza/mall/$2/xml/pasando.xml
cp /home/ddmallplaza/xml2json/$1/descuentos.json /home/ddmallplaza/mall/$2/json/descuentos.json
cp /home/ddmallplaza/xml2json/$1/cine.json /home/ddmallplaza/mall/$2/json/cine.json
cp /home/ddmallplaza/xml2json/$1/eventos.json /home/ddmallplaza/mall/$2/json/eventos.json
cp /home/ddmallplaza/xml2json/$1/pasando.json /home/ddmallplaza/mall/$2/json/pasando.json
rm *.xml
pm2 reload all
exit

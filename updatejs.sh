#!/bin/bash
sudo service polipo stop
sudo polipo -x
wget http://www.mallplaza.cl/xml/descuentos.php?siteid=mallplaza-$1 --output-document=descuentos.xml && sleep 10 && wget http://www.mallplaza.cl/xml/cine.php?siteid=mallplaza-$1 --output-document=cine.xml && sleep 10 && wget http://www.mallplaza.cl/xml/eventos.php?siteid=mallplaza-$1 --output-document=eventos.xml && sleep 10 && wget http://www.mallplaza.cl/xml/queestapasando.php?siteid=mallplaza-$1 --output-document=pasando.xml
sleep 5
ls pasando.xml >/dev/null || exit
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:8123 descuentos.xml -f //imagen
sleep 5
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:8123 cine.xml -f //afiche
sleep 5
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:8123 eventos.xml -f //afiche
sleep 5
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:8123 pasando.xml -f //imagen
sleep 5
rm *.xml
sudo cp /home/ddmallplaza/xml2json/$1/descuentos.json /home/ddmallplaza/mall/$2/json/descuentos.json
sudo cp /home/ddmallplaza/xml2json/$1/cine.json /home/ddmallplaza/mall/$2/json/cine.json
sudo cp /home/ddmallplaza/xml2json/$1/eventos.json /home/ddmallplaza/mall/$2/json/eventos.json
sudo cp /home/ddmallplaza/xml2json/$1/pasando.json /home/ddmallplaza/mall/$2/json/pasando.json
pm2 reload all
exit

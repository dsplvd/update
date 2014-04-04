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
cp descuentos.xml /home/ddmallplaza/mall/$2/xml/descuentos.xml
cp cine.xml /home/ddmallplaza/mall/$2/xml/cine.xml
cp eventos.xml /home/ddmallplaza/mall/$2/xml/eventos.xml
cp pasando.xml /home/ddmallplaza/mall/$2/xml/pasando.xml
rm *.xml
pm2 reload all
exit

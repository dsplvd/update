#!/bin/bash
wget http://www.mallplaza.cl/xml/descuentos.php?siteid=mallplaza-$1 --output-document=descuentos.xml && sleep 10 && wget http://www.mallplaza.cl/xml/cine.php?siteid=mallplaza-$1 --output-document=cine.xml && sleep 10 && wget http://www.mallplaza.cl/xml/eventos.php?siteid=mallplaza-$1 --output-document=eventos.xml && sleep 10 && wget http://www.mallplaza.cl/xml/queestapasando.php?siteid=mallplaza-$1 --output-document=pasando.xml && sleep 10 && wget http://www.mallplaza.cl/xml/tiendas.php?siteid=mallplaza-$1 --output-document=tiendas.xml
sleep 5
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:8123 descuentos.xml -f //imagen
sleep 10
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:8123 cine.xml -f //afiche
sleep 10
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:8123 eventos.xml -f //afiche
sleep 10
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:8123 pasando.xml -f //imagen
exit

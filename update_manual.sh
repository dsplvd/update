#!/bin/bash
wget http://www.mallplaza.cl/xml/descuentos.php?siteid=mallplaza-$1 --output-document=descuentos.xml && sleep 10 && wget http://www.mallplaza.cl/xml/cine.php?siteid=mallplaza-$1 --output-document=cine.xml && sleep 10 && wget http://www.mallplaza.cl/xml/eventos.php?siteid=mallplaza-$1 --output-document=eventos.xml && wget http://www.mallplaza.cl/xml/tiendas.php?siteid=mallplaza-$1 --output-document=tiendas.xml
ls tiendas.xml >/dev/null || exit
sudo squid3 -k shutdown
sudo service squid3 stop
sudo mv /home/ddmallplaza/squid_cache.old /home/ddmallplaza/squid_cache.borrar
sudo mv /home/ddmallplaza/squid_cache /home/ddmallplaza/squid_cache.old
mkdir /home/ddmallplaza/squid_cache
sudo chown proxy:proxy /home/ddmallplaza/squid_cache
sudo squid3 -z
sudo squid3
sudo service squid3 start
sleep 5
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:3128 descuentos.xml -f //imagen
sleep 10
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:3128 cine.xml -f //afiche
sleep 10
/home/ddmallplaza/update/./xidel --proxy=127.0.0.1:3128 eventos.xml -f //afiche
sudo mv /opt/lampp/htdocs/$2/src/xml.old /opt/lampp/htdocs/pal1/src/xml.borrar
sudo mv /opt/lampp/htdocs/$2/src/xml /opt/lampp/htdocs/pal1/src/xml.old
sudo mkdir /opt/lampp/htdocs/$2/src/xml
sudo cp descuentos.xml /opt/lampp/htdocs/$2/src/xml/descuentos.xml
sudo cp cine.xml /opt/lampp/htdocs/$2/src/xml/cine.xml
sudo cp eventos.xml /opt/lampp/htdocs/$2/src/xml/eventos.xml
sudo cp tiendas.xml /opt/lampp/htdocs/$2/src/xml/tiendas.xml
sudo rm *.xml
sudo rm -rf /home/ddmallplaza/squid_cache.borrar
sudo rm -rf /opt/lampp/htdocs/$2/src/xml.old
exit

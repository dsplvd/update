#!/bin/bash
wget http://www.mallplaza.cl/xml/descuentos.php?siteid=mallplaza-norte --output-document=descuentos.xml && sleep 10 && wget http://www.mallplaza.cl/xml/cine.php?siteid=mallplaza-norte --output-document=cine.xml && sleep 10 && wget http://www.mallplaza.cl/xml/eventos.php?siteid=mallplaza-norte --output-document=eventos.xml
ls eventos.xml >/dev/null || exit
sudo squid3 -k shutdown
sudo service squid3 stop
mv /home/ddmallplaza/squid_cache.old /home/ddmallplaza/squid_cache.borrar
mv /home/ddmallplaza/squid_cache /home/ddmallplaza/squid_cache.old
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
sudo mv /opt/lampp/htdocs/pno1/src/xml.old /opt/lampp/htdocs/pal1/src/xml.borrar
sudo mv /opt/lampp/htdocs/pno1/src/xml /opt/lampp/htdocs/pal1/src/xml.old
sudo mkdir /opt/lampp/htdocs/pno1/src/xml
cp descuentos.xml /opt/lampp/htdocs/pno1/src/xml/descuentos.xml
cp descuentos.xml /opt/lampp/htdocs/pno1/src/xml/descuentos2.xml
cp descuentos.xml /opt/lampp/htdocs/pno1/src/xml/descuentosDesc.xml
cp cine.xml /opt/lampp/htdocs/pno1/src/xml/cine.xml
cp cine.xml /opt/lampp/htdocs/pno1/src/xml/cine2.xml
cp cine.xml /opt/lampp/htdocs/pno1/src/xml/cineDesc.xml
cp eventos.xml /opt/lampp/htdocs/pno1/src/xml/eventos.xml
cp eventos.xml /opt/lampp/htdocs/pno1/src/xml/eventos2.xml
cp eventos.xml /opt/lampp/htdocs/pno1/src/xml/eventosDesc.xml
sudo rm *.xml
sudo rm -rf /home/ddmallplaza/squid_cache.borrar
sudo rm -rf /opt/lampp/htdocs/pal1/src/xml.old
exit

#!/bin/bash
ping -c 4 mallplaza.cl && wget http://www.mallplaza.cl/xml/tiendas.php?siteid=mallplaza-$1 --output-document=tiendas_$2.xml
ls tiendas_$2.xml >/dev/null || exit
sudo /opt/lampp/bin/./php bin/php tiendas_cvs.php tiendas_$2.xml
sudo /opt/lampp/bin/./php bin/php tiendas_sql.php $2
exit

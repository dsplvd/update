#!/bin/bash
wget http://www.mallplaza.cl/xml/tiendas.php?siteid=mallplaza-$1 --output-document=tiendas_$2.xml
ls tiendas_$2.xml >/dev/null || exit
sudo /opt/lampp/bin/php tiendas_cvs.php $2
sudo /opt/lampp/bin/php tiendas_sql.php $2
sudo rm -f tiendas_$2.xml
sudo rm -f datos_$2.cvs
exit

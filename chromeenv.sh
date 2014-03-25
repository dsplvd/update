#!/bin/bash
wget --delete-after http://localhost/$MALL/descuentos.html
wget --delete-after http://localhost/$MALL/cine.html
wget --delete-after http://localhost/$MALL/eventos.html
wget --delete-after http://localhost/$MALL/src/js/tiendas.js
wget --delete-after http://localhost/$MALL/src/js/descuentos.js
wget --delete-after http://localhost/$MALL/src/js/eventos.js
wget --delete-after http://localhost/$MALL/src/js/cine.js
export DISPLAY=:0.0
xinput set-prop "FREE INTERACTIVE TECHNOLOGY " "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
openbox & google-chrome http://localhost/$MALL --kiosk --incognito --proxy-server=127.0.0.1:3128 --disk-cache-dir=/dev/null --disable-translate

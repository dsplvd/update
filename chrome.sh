#!/bin/bash
wget --delete-after http://localhost/$1/descuentos.html
wget --delete-after http://localhost/$1/cine.html
wget --delete-after http://localhost/$1/eventos.html
wget --delete-after http://localhost/$1/src/js/tiendas.js
wget --delete-after http://localhost/$1/src/js/descuentos.js
wget --delete-after http://localhost/$1/src/js/eventos.js
wget --delete-after http://localhost/$1/src/js/cine.js
export DISPLAY=:0.0
xinput set-prop "FREE INTERACTIVE TECHNOLOGY " "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
openbox & google-chrome http://localhost/$1 --kiosk --incognito --proxy-server=127.0.0.1:3128 --disk-cache-dir=/dev/null --disable-translate

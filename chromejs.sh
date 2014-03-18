#!/bin/bash
export DISPLAY=:0.0
xinput set-prop "FREE INTERACTIVE TECHNOLOGY " "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
openbox & google-chrome http://localhost:3000 --kiosk --incognito --proxy-server=127.0.0.1:8123 --disk-cache-dir=/dev/null --disable-translate

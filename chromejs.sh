#!/bin/bash
export DISPLAY=:0.0
xset -dpms
xset s off
xinput set-prop "FREE INTERACTIVE TECHNOLOGY " "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
openbox & google-chrome http://localhost:3000 --kiosk --incognito --proxy-server=127.0.0.1:3128 --disk-cache-dir=/dev/null

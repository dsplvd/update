#!/bin/bash
sudo service squid3 stop
sudo rm -rf /home/ddmallplaza/squid_cache/*
sudo squid3 -z
sudo service squid3 start
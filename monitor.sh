#!/bin/bash
#
# /root/bin/mythmon
# This is run from cron every 5 minutes.
#

ps -C squid3 > /dev/null && exit 0;

exit 1;

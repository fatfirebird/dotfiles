#!/usr/bin/python3

import os

ssid = os.popen("iwconfig 2>&1 \
                | grep 'ESSID' \
                | awk -F\\\" '{print $2}'").read()

if not ssid.strip():
    print('睊')
else:
    print('直   ' + ssid)

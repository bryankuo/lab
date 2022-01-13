#!/usr/bin/python3

# python3 a905_component.py
# return 0

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

#
url = "https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm?MSCI=0"
# 00733 holdings:
# https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=00733.TW
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
rows = soup.find_all("table", {})[2] \
        .find_all("tr")
index = 1
for i in range(3, len(rows)):
    rank      = str(index)
    tkr_name  = rows[i].find_all('td')[0].text.strip()
    mkt_value = rows[i].find_all('td')[1].text
    weight = rows[i].find_all('td')[2].text
    print( \
        rank + ":" + \
        tkr_name + ":" + \
        mkt_value + ":" + \
        weight )
    index += 1

sys.exit(0)

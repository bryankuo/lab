#!/usr/bin/python3

# python3 msci_components.py
# get listed daily average volume for one year
# return 0: not found, assume otc

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

url = "https://stock.capital.com.tw/z/zm/zmd/zmdc.djhtm?MSCI=0"
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
table = soup.find_all("table", {})
if ( table is None ):
    print("table not found")
    sys.exit(1)
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

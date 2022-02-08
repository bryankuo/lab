#!/usr/bin/python3

# python3 msci_components.py
# get listed daily average volume for one year
# return 0: not found, assume otc

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

title = ['排名', '代號名稱', '市值(M)', '台股權值']

url = "https://stock.capital.com.tw/z/zm/zmd/zmdc.djhtm?MSCI=0"
response = requests.get(url)
# https://bit.ly/3nbzGEG
response.encoding = 'cp950'
soup = BeautifulSoup(response.text, 'html.parser')
table = soup.find_all("table", {})
if ( table is None ):
    print("table not found 1")
    sys.exit(1)
rows = soup.find_all("table", {})[2] \
        .find_all("tr")
if ( len(rows) <= 0 ):
    print("table not found 2")
    sys.exit(2)
for i in range(0, len(title)):
    if ( i != len(title)-1 ):
        print(title[i], end=":")
    else:
        print(title[i], end="\n")
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

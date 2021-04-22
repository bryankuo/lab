#!/usr/bin/python3

# python3 quote.py 2330
# return 0: not found, assume otc

import sys, requests, time, json
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
# @see shorturl.at/elwzD
# https://mis.twse.com.tw/stock/api/getStockInfo.jsp?ex_ch=tse_9904.tw%7C&json=1&d=20210422&delay=0&_=1432626332924
url = 'https://mis.twse.com.tw/stock/api/getStockInfo.jsp?' + \
    'ex_ch=tse_' + ticker + '.tw%7C' + \
    '&json=1' + '&d=20210422&delay=0&_=1432626332924'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
frame = json.loads(soup.text)
print(json.dumps(frame, indent=1))
# @see https://cutt.ly/kvJMxty
sys.exit(0)

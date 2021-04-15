#!/usr/bin/python3

# python3 margin_ratio.py 2330
# get listed daily average volume for one year
# return 0: not found, assume otc

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = 'https://concords.moneydj.com/z/zc/zcn/zcn_' + ticker + '.djhtm'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
rows = soup.findAll('tr')[10]
if ( rows is None ):
    sys.exit(1)
td = rows.findAll('td')[13]
print(ticker + " margin ratio: " + td.text)
sys.exit(0)

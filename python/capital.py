#!/usr/bin/python3

# python3 capital.py 2330
# get listed daily average volume for one year
# return 0: not found, assume otc

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = 'https://tw.stock.yahoo.com/d/s/company_' + ticker + '.html'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
rows = soup.findAll('tr')[12]
if ( rows is None ):
    sys.exit(1)
td = rows.findAll('td')[1]
if ( td is None ):
    sys.exit(2)
print(ticker + " capital: " + td.text)
sys.exit(0)

#!/usr/bin/python3

# python3 beta.py 2330
# return 0: not found, assume otc

import sys, requests, time, re
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = 'http://5850web.moneydj.com/z/zc/zcx/zcxNew_' + ticker + '.djhtm'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
answer = soup.findAll('table')[3].find_all('tr')[7].find_all('td')[5].text
if ( answer is None ):
    sys.exit(1)
print(ticker + " beta: " + answer)
sys.exit(0)

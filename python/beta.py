#!/usr/bin/python3

# python3 beta.py 2330
# return 0: not found, assume otc

import sys, requests, time, re, pprint
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = 'http://5850web.moneydj.com/z/zc/zcx/zcxNew_' + ticker + '.djhtm'
# source 2
# https://www.sinotrade.com.tw/Stock/Stock_3_1/Stock_3_1_4_1?ticker=2890
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
beta = soup.findAll('table')[3].find_all('tr')[7].find_all('td')[5].text
pe = soup.findAll('table')[3].find_all('tr')[3].find_all('td')[1].text
pe_peer = soup.findAll('table')[3].find_all('tr')[4].find_all('td')[1].text
pe_hi = soup.findAll('table')[3].find_all('tr')[4].find_all('td')[3].text
pe_lo = soup.findAll('table')[3].find_all('tr')[4].find_all('td')[5].text
if ( beta is None ):
    sys.exit(1)
print(ticker + " beta: " + beta)
print(ticker + " PE  : " + pe + " h: " + pe_hi + " l: " + pe_lo + " peer: " + pe_peer )
sys.exit(0)

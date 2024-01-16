#!/usr/bin/python3

# python3 margin_ratio.py 2330
# get listed daily average volume for one year
# return 0: not found, assume otc

import sys, requests, time, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
sys.path.append(os.getcwd())
import useragents as ua
import sites

ticker = sys.argv[1]
url = 'https://concords.moneydj.com/z/zc/zcn/zcn_' + ticker + '.djhtm'
# source
# https://stock.wearn.com/acredit.asp?year=112&month=08&kind=2913
#

# https://ebroker-dj.fbs.com.tw/z/zg/zg_E_0_-1.djhtm

# https://histock.tw/stock/three.aspx?m=mg

# security lending
# https://www.twse.com.tw/zh/products/sbl/disclosures/t13sa710.html

response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
rows = soup.findAll('tr')[10]
if ( rows is None ):
    sys.exit(1)
td = rows.findAll('td')[13]
print(ticker + " margin ratio: " + td.text)
sys.exit(0)

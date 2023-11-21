#!/usr/bin/python3

# python3 board.py 2330
# return 0: not found, assume otc

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]

# https://moneydj.emega.com.tw/z/zc/zco/zco0/zco0.djhtm?a=2886&BHID=7000&b=7006&C=

# https://moneydj.emega.com.tw/z/zc/zco/zco0/zco0.djhtm?a=2886&BHID=5460&b=5460

# BHID

# https://tv.moneydj.com/z/zc/zco/zco0/zco0.djhtm?a=2409&BHID=1030&b=1039&C=1

# summary
# https://moneydj.emega.com.tw/z/zc/zco/zco.djhtm?a=2886

# url = "https://moneydj.emega.com.tw/z/zc/zco/zco.djhtm?a=2886"
url = "https://tv.moneydj.com/z/zc/zco/zco0/zco0.djhtm?a=2409&BHID=1030&b=1039&C=1"
# KGI branch is up to 58
# https://moneydj.emega.com.tw/z/zc/zco/zco0/zco0.djhtm?a=2886&BHID=9200&b=9258

# data = {
#    "firstin": "true", "year": "110", "month": "03", \
#    "co_id": ticker, "TYPEK": "sii", "step": 0}
# response = requests.post(url, data)
# soup = BeautifulSoup(response.text, 'html.parser')
# print(soup.prettify())
# ready to scrap
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
# rows = soup.findAll('tr')[12]
print(soup.prettify())
if ( rows is None ):
    sys.exit(1)

sys.exit(0)

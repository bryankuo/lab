#!/usr/bin/python3

# python3 branch.py 2330
# return 0: success

import sys, requests, time, re, os, webbrowser
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = "https://histock.tw/stock/branch.aspx?no="+ticker
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
# rows = soup.findAll('table')[1].find_all('tr')
"""
rows= soup \
    .find_all("table", {"class": "tbChip"})[0] \
    .find_all('tr')[1]
if ( rows is None ):
    print("not found")
    sys.exit(-2)
print(rows)
"""

# by ticker symbol
# date is available
# https://histock.tw/stock/branch.aspx?no=1514&from=20210713&to=20210713

# by broker
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=1380&b=1380&c=B&e=2021-12-1&f=2021-12-3

webbrowser.open(url)
sys.exit(0)

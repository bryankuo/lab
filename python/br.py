#!/usr/bin/python3

# python3 br.py [address]
# return 0: list

import sys, requests, time, re, os, webbrowser
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
import difflib

# @see https://www.twse.com.tw/zh/brokerService/brokerServiceAudit
geo_group = ['台北市', '基隆市', '新北市', '桃園市',   \
    '新竹縣', '新竹市', '苗栗縣', '台中市', '南投縣',  \
    '彰化市', '彰化縣', '雲林縣', '嘉義市', '嘉義縣',  \
    '台南市', '台南縣', \
    '高雄市', '鳳山市', '屏東市', '屏東縣', '宜蘭縣',  \
    '花蓮縣', '花連市', '澎湖縣', \
    '金門縣' ]

#

addr = sys.argv[1]
print(difflib.get_close_matches(addr, geo_group))
sys.exit(0)

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
# date is available, at most 14 days in range
# https://histock.tw/stock/branch.aspx?no=1514&from=20210713&to=20210713

# by broker
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=1380&b=1380&c=B&e=2021-12-1&f=2021-12-3

# @see transaction.py parsing frame html source
# 買賣日報表查詢系統 https://bsr.twse.com.tw/bshtm/
# or download csv file

# webbrowser.open(url)
sys.exit(0)

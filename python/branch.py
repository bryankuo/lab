#!/usr/bin/python3

# python3 branch.py 2330
# return 0: success

import sys, requests, time, re, os, webbrowser
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]

# trades = "b.txt" # download html
# with open(trades) as fp:
#    soup = BeautifulSoup(fp, 'html.parser')

url = "https://histock.tw/stock/branch.aspx?no="+ticker
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

table = soup \
    .find_all("table", {"class": "tb-stock tbChip tbHide"})[0]
if ( table is None ):
    print("table not found")
    sys.exit(-2)
# print(table.prettify())

rows = table.find_all('tr')

ths = rows[0].find_all('th')
for th in ths:
    print(th.text.strip(), end=':')
print("\r")

tds = rows[0].find_all('td')
for i in range(1, len(rows)):
    tds = rows[i].find_all('td')
    col = 0
    for td in tds:
        if col in [0, 5] :
            # broker = td.find_all("a")[0].text.strip()
            # bs documentation @see https://tinyurl.com/satpd5rk
            url = td.find_all('a')[0].get('href').strip()
            mark1 = 'bno='; start = url.find(mark1)
            mark2 = '&'   ; end   = url.find(mark2)
            bno = url[start+len(mark1):end]
        text = td.text.strip()
        if col in [1, 2, 3, 6, 7, 8] and len(text) <= 0 :
            text = "0"
        if col in [0, 5] :
            text = bno + text
        print(text, end=":")
        col += 1
    print("\r")

sys.exit(0)

# by ticker symbol
# date is available, at most 14 days in range
# https://histock.tw/stock/branch.aspx?no=1514&from=20210713&to=20210713

# by broker
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=1380&b=1380&c=B&e=2021-12-1&f=2021-12-3

# @see transaction.py parsing frame html source
# 買賣日報表查詢系統 https://bsr.twse.com.tw/bshtm/
# or download csv file

# @see https://www.twse.com.tw/zh/brokerService/brokerServiceAudit
geo_group = ['台北市', '基隆市', '新北市', '桃園市',   \
    '新竹縣', '新竹市', '苗栗縣', '台中市', '南投縣',  \
    '彰化市', '彰化縣', '雲林縣', '嘉義市', '嘉義縣',  \
    '台南市', '台南縣', \
    '高雄市', '鳳山市', '屏東市', '屏東縣', '宜蘭縣',  \
    '花蓮縣', '花連市', '澎湖縣', \
    '金門縣' ]

# pygmap package to draw plot
# pip install pygmaps
# python3 -m pip install pygmaps
# mac seems not working
# open street map?
# google earth
# https://earth.google.com/web/@44.54109221,-65.63571745,8615.44979582a,22243136.74901247d,35y,0h,0t,0r
# trying open 2 maps in webbrowser, input coordinates
# ref gmap.py

# enumerate 10 minor id of interest
# ref: https://cutt.ly/GFZrjFd

# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9200&9268
# 9217
# 9875
# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9600&b=9658
# a=9600&b=9697

# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9100&b=0039003100380065
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=8880&b=8880
# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=8450&b=0038003400350042
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=8440&b=8440
# http://jsjustweb.jihsun.com.tw/z/zg/zgb/zgb0.djhtm?a=8440&b=8440
broker_group = [ \
    9200, 9268, 9217, 9875, 9658, \
    9697, 9100, 8880, 8450, 8440, \
]

webbrowser.open(url)
sys.exit(0)

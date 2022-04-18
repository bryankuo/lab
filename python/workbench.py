#!/usr/bin/python3

# python3 commodities.py

import sys, requests, time, webbrowser
import urllib.request
from urllib.parse   import quote
from urllib.request import urlopen

from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = 2330
if ( len(sys.argv) >= 2 ):
    ticker = sys.argv[1]

typ2 ="https://bsr.twse.com.tw/bshtm/"

typ4 ="https://www.tpex.org.tw/web/stock/aftertrading/broker_trading/brokerBS.php?l=zh-tw"

src2 ="https://histock.tw/stock/branch.aspx?no=" + ticker

src3 ="https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9200&b=9208"
src4 ="https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=8440&b=8440"
src5 ="http://jsjustweb.jihsun.com.tw/z/zg/zgb/zgb0.djhtm?a=8440&b=8440"


technical ="https://invest.cnyes.com/twstock/TWS/2015/technical"
yh
="https://tw.stock.yahoo.com/news/籌碼達人1-3步驟抓出-關鍵券商-他跟著大戶下單賺飆股-215910545.html"

urls = [ typ2, typ4, src2, src3, src4, src5, technical, yh ]

i = 0
for url in urls:
    webbrowser.open(url)
    time.sleep(1)
    i += 1
    if ( i % 10 == 9 ):
        print('\a') # beep
        input("Press Enter to continue...")

sys.exit(0)

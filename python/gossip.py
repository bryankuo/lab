#!/usr/bin/python3

# python3 board.py 2330
# return 0: not found, assume otc

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = "https://www.cmoney.tw/follow/channel/stock-" + \
    ticker +"?chart=d&type=Personal"
webbrowser.open(url)
sys.exit(0)

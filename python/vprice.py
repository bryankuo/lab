#!/usr/bin/python3

# python3 vprice.py 2330
# return 0 success

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]

url = "https://www.esunsec.com.tw/tw-stock/z/zc/zcw/zcwg/zcwg.djhtm?id=" + ticker

webbrowser.open(url)

sys.exit(0)

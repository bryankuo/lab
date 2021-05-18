#!/usr/bin/python3

# python3 fundamental.py 2330
# return 0: success

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = "http://jsjustweb.jihsun.com.tw/Z/ZC/ZCV/ZCV_" + ticker + ".djhtm"
webbrowser.open(url)
sys.exit(0)

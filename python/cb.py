#!/usr/bin/python3

# python3 cb.py 2330
# return 0: not found, assume otc

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
# cb detail
# https://thefew.tw/quote/33462
url = 'http://mops.twse.com.tw/mops/web/ajax_t05st03?TYPEK=all&step=1&firstin=1&off=1&queryName=co_id&co_id=' + ticker
webbrowser.open(url)
sys.exit(0)

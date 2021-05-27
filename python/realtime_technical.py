#!/usr/bin/python3

# python3 institution_holdings.py 2330
# return 0: success

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]
# url = "https://stock.cnyes.com/market/TWS:"+ticker+":STOCK"
url = "https://invest.cnyes.com/twstock/TWS/" + ticker + "/technical"
webbrowser.open(url)
sys.exit(0)

#!/usr/bin/python3

# python3 br_ticker.py [ticker]
# return 0: success

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = "https://bsr.twse.com.tw/bshtm/?TextBox_Stkno=" + ticker
webbrowser.open(url)
sys.exit(0)

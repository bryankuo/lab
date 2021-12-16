#!/usr/bin/python3

# python3 news.py 2330
# return 0: success

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = "http://jsjustweb.jihsun.com.tw/Z/ZC/ZCV/ZCV_" + ticker + ".djhtm"
webbrowser.open(url)
# https://www.google.com/search?q=晟德+4123+新聞&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWCJaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1
sys.exit(0)

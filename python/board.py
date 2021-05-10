#!/usr/bin/python3

# python3 board.py 2330
# return 0: not found, assume otc

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]
# https://mops.twse.com.tw/mops/web/stapap1_all
# board holdings, got valid data, 2 months earlier
the_day = datetime.today() + relativedelta(months=-2)
yr = str(int(the_day.strftime("%Y")) - 1911)
month = the_day.strftime("%m")

# url = "https://mops.twse.com.tw/mops/web/ajax_stapap1"
# data = {
#    "firstin": "true", "year": "110", "month": "03", \
#    "co_id": ticker, "TYPEK": "sii", "step": 0}
# response = requests.post(url, data)
# soup = BeautifulSoup(response.text, 'html.parser')
# print(soup.prettify())
# ready to scrap

url = "https://mops.twse.com.tw/mops/web/ajax_stapap1" + \
    "?firstin=true&year=" + yr + "&month=" + month + \
    "&co_id=" + ticker + "&TYPEK=sii&step=0"
webbrowser.open(url)

url = "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca.djhtm?a=" + ticker
webbrowser.open(url)

url = "https://stock.cnyes.com/market/TWS:"+ticker+":STOCK"
webbrowser.open(url)

url = "http://jsjustweb.jihsun.com.tw/Z/ZC/ZCV/ZCV_" + ticker + ".djhtm"
webbrowser.open(url)

# url = "https://mops.twse.com.tw/mops/web/t51sb10_q1"
# "https://mops.twse.com.tw/mops/web/t05sr01_1#"
sys.exit(0)

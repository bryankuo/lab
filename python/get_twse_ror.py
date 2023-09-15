#!/usr/bin/python3

# python3 get_twse_ror.py
# return 0

'''
import sys, requests, time, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
'''

import sys, requests, time, os, numpy
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

# url = "https://www.macromicro.me/charts/36436/tai-wan-gu-shi-da-pan-zhi-shu-bao-chou-lyu"
url = "https://www.moneydj.com/iquote/iQuoteChart.djhtm?a=AI001059"

# // TODO: relative strength
# https://tw.stock.yahoo.com/rank/change-down
# https://www.wantgoo.com/stock/ranking/top-loser
# https://www.cmoney.tw/finance/f00016.aspx?o=2&o2=2

# zca
# twse history
# https://www.twse.com.tw/rwd/zh/TAIEX/MI_5MINS_HIST?date=20230701&response=html
# https://goodinfo.tw/tw/StockIdxDetail.asp?STOCK_ID=%E5%8A%A0%E6%AC%8A%E6%8C%87%E6%95%B8
# https://www.macromicro.me/charts/36436/tai-wan-gu-shi-da-pan-zhi-shu-bao-chou-lyu
# 臺灣加權指數與相關指數
# https://www.moneydj.com/iquote/iQuoteChart.djhtm?a=AI001059 ( works )

DIR0="."
fname = "ror.html"
path = os.path.join(DIR0, fname)
is_from_net = False # True
use_plain_req = False

if ( is_from_net ):
    # os.remove(path) # clean up
    if ( use_plain_req ):
        response = requests.get(url)
        # response.encoding = 'cp950'
        soup = BeautifulSoup(response.text, 'html.parser')
    else:
        browser = webdriver.Safari( \
            executable_path = '/usr/bin/safaridriver')
        browser.get(url)
        time.sleep(1)
        page1 = browser.page_source
        soup = BeautifulSoup(page1, 'html.parser')
        browser.quit()
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
else:
    with open(path) as q:
        soup = BeautifulSoup(q, 'html.parser')

title = soup.find_all("table", {"class": "t01"})[0] \
        .find_all("tr", {})[1].text.strip().replace(',', '')
ttl_1d = soup.find_all("table", {"class": "t01"})[0] \
        .find_all("tr", {})[1] \
        .find_all("td", {})[1].text.strip().replace(',', '')
ttl_1w = soup.find_all("table", {"class": "t01"})[0] \
        .find_all("tr", {})[1] \
        .find_all("td", {})[2].text.strip().replace(',', '')
ttl_1m = soup.find_all("table", {"class": "t01"})[0] \
        .find_all("tr", {})[1] \
        .find_all("td", {})[3].text.strip().replace(',', '')
print(ttl_1)

figure = soup.find_all("table", {"class": "t01"})[0] \
        .find_all("tr", {})[2].text.strip().replace(',', '')
print(figure)

sys.exit(0)

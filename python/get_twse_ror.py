#!/usr/bin/python3

# python3 get_twse_ror.py
# \param out ror.YYYYMMDD.csv
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

if ( len(sys.argv) == 1 ):
    yyyymmdd = datetime.today().strftime('%Y%m%d')
elif ( len(sys.argv) == 2 ):
    yyyymmdd = sys.argv[1]

DIR0="./datafiles/taiex/rs"
DIR1 = os.path.join(DIR0, yyyymmdd)

fname = "ror.twse.html"
path = os.path.join(DIR1, fname)

ofname = "ror." + yyyymmdd + '.csv' # 1st gen
o_path = os.path.join(DIR0, ofname)

is_from_net = True
use_plain_req = False

if ( is_from_net ):
    if ( use_plain_req ):
        response = requests.get(url)
        # response.encoding = 'cp950'
        soup = BeautifulSoup(response.text, 'html.parser')
    else:
        browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
        browser.implicitly_wait(20)
        browser.maximize_window()
        browser.switch_to.window(browser.current_window_handle)
        browser.get(url)
        # time.sleep(1)
        page1 = browser.page_source
        soup = BeautifulSoup(page1, 'html.parser')
        browser.minimize_window()
        browser.quit()
        with open(path, "w") as outfile2:
            outfile2.write(soup.prettify())
            outfile2.close()
else:
    with open(path) as q:
        soup = BeautifulSoup(q, 'html.parser')

title = soup.find_all("table", {"class": "t01"})[0] \
    .find_all("tr", {})[1]
t_1d  = title.find_all("td", {})[1].text.strip().replace(',', '')
t_1w  = title.find_all("td", {})[2].text.strip().replace(',', '')
t_1m  = title.find_all("td", {})[3].text.strip().replace(',', '')
t_3m  = title.find_all("td", {})[4].text.strip().replace(',', '')
t_6m  = title.find_all("td", {})[5].text.strip().replace(',', '')
t_1y  = title.find_all("td", {})[6].text.strip().replace(',', '')
t_ytd = title.find_all("td", {})[7].text.strip().replace(',', '')
t_3y  = title.find_all("td", {})[8].text.strip().replace(',', '')

olist0 = [ t_1d, t_1w, t_1m, t_3m, t_6m, t_1y, t_ytd, t_3y ]

figure = soup.find_all("table", {"class": "t01"})[0] \
    .find_all("tr", {})[2]
f_1d   = figure.find_all("td", {})[1].text.strip().replace(',', '')
f_1w   = figure.find_all("td", {})[2].text.strip().replace(',', '')
f_1m   = figure.find_all("td", {})[3].text.strip().replace(',', '')
f_3m   = figure.find_all("td", {})[4].text.strip().replace(',', '')
f_6m   = figure.find_all("td", {})[5].text.strip().replace(',', '')
f_1y   = figure.find_all("td", {})[6].text.strip().replace(',', '')
f_ytd  = figure.find_all("td", {})[7].text.strip().replace(',', '')
f_3y   = figure.find_all("td", {})[8].text.strip().replace(',', '')

if ( float(f_ytd) == 0 ):
    f_ytd = f_1y # fix ytd division by 0 issue @ start of yr

olist = [ f_1d, f_1w, f_1m, "n/a", f_3m, f_6m, f_1y, f_ytd, f_3y ]
print(olist)
# return for ticker ror parameters.

with open(o_path, 'a') as ofile:
    # ofile.write("ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y\n")
    ofile.write("tse:台股加權:"+f_1d+":"+f_1w+":"+f_1m+":n/a:"+f_3m \
        +":"+f_6m+":"+f_1y+":"+f_ytd+":"+f_3y+"\n")
    ofile.close()

sys.exit(0)

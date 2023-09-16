#!/usr/bin/python3

# python3 get_ticker_ror.py
# return 0

'''
import sys, requests, time, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
'''

import sys, requests, time, os, numpy, random
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

# twse history
# https://www.twse.com.tw/rwd/zh/TAIEX/MI_5MINS_HIST?date=20230701&response=html
# https://goodinfo.tw/tw/StockIdxDetail.asp?STOCK_ID=%E5%8A%A0%E6%AC%8A%E6%8C%87%E6%95%B8
# https://www.macromicro.me/charts/36436/tai-wan-gu-shi-da-pan-zhi-shu-bao-chou-lyu
# 臺灣加權指數與相關指數
# https://www.moneydj.com/iquote/iQuoteChart.djhtm?a=AI001059 ( works )

if ( len(sys.argv) < 2 ):
    print("usage: get_ticker_ror.py [ticker]")
    sys.exit(0)
ticker = sys.argv[1]

# DIR0="./datafiles"
DIR0="."
fname = "ror." + ticker + ".html"
path = os.path.join(DIR0, fname)
ofname = "ror." + datetime.today().strftime('%Y%m%d') + '.txt'
o_path = os.path.join(DIR0, ofname)

is_from_net = True
use_plain_req = True

def select_src(ticker, seed):
    print( "ticker " + ticker + ", src " + str(seed) )
    # zca
    if ( seed == 1 ):
        # https://concords.moneydj.com/z/zc/zca/zca_2102.djhtm
        src1 = "https://concords.moneydj.com/z/zc/zca/zca_" + ticker + ".djhtm"
        return src1
    elif ( seed == 2 ):
        # https://fubon-ebrokerdj.fbs.com.tw/z/zc/zca/zca_2102.djhtm
        src2 = "https://fubon-ebrokerdj.fbs.com.tw/z/zc/zca/zca_" + ticker + ".djhtm"
        return src2
    elif ( seed == 3 ):
        # http://jsjustweb.jihsun.com.tw/z/zc/zca/zca_2102.djhtm
        src3 = "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca_" + ticker + ".djhtm"
        return src3
    elif ( seed == 4 ):
        # "https://trade.ftsi.com.tw/z/zc/zca/zca_1589.djhtm"
        src4 = "https://trade.ftsi.com.tw/z/zc/zca/zca_" + ticker + ".djhtm"
        return src4
    elif ( seed == 5 ):
        # https://just2.entrust.com.tw/z/zc/zca/zca.djhtm?A=2303
        src5 = "https://just2.entrust.com.tw/z/zc/zca/zca.djhtm?A=" + ticker
        return src5
    else:
        # https://concords.moneydj.com/z/zc/zca/zca_2102.djhtm
        src1 = "https://concords.moneydj.com/z/zc/zca/zca_" + ticker + ".djhtm"
        return src1

if ( is_from_net ):
    if ( os.path.exists(path) ):
        os.remove(path) # clean up
    if ( use_plain_req ):
        url = select_src( ticker, random.randint(1,5))
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

# title = soup.find("meta",  {"name":"description"})
name = "n/a" #title["content"].split(' ')[0].split(')')[1].strip()

r_ytd = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[8] \
    .find_all('td')[1].text.strip()

r_1w  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[9] \
    .find_all('td')[1].text.strip()

r_1m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[9] \
    .find_all('td')[1].text.strip()

r_2m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[10] \
    .find_all('td')[1].text.strip()

r_3m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[10] \
    .find_all('td')[1].text.strip()

# olist =   [ f_1d,  f_1w, f_1m, "n/a", f_3m, f_6m,  f_1y,  f_ytd, f_3y  ]
olist   =   [ "n/a", r_1w, r_1m, r_2m,  r_3m, "n/a", "n/a", r_ytd, "n/a" ]
#print(olist)
# assume get_twse_ror.py is running at first
with open(o_path, 'a') as ofile:
    # ofile.write("ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y\n")
    ofile.write(ticker+":"+name+":n/a:"+r_1w+":"+r_1m+":"+r_2m+":"+r_3m \
        +":n/a:n/a:"+r_ytd+":n/a"+"\n")
    ofile.close()

sys.exit(0)

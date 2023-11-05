#!/usr/bin/python3

# python3 fetch_ticker_ror.py [tkr] [net|file]
# fetch ticker ror from broker, serving ror.sh
# \param in ticker
# \param in 0: from internet, 1: from file
# \param out ror.YYYYMMDD.csv, append, created by get_twse_ror.py
# \param out ror.[ticker].html
# return 0

import sys, requests, time, os, numpy, random, csv
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

if ( len(sys.argv) < 3 ):
    print("usage: fetch_ticker_ror.py [ticker] [net|file]")
    sys.exit(0)
ticker = sys.argv[1]
if ( int(sys.argv[2]) == 1 ):
    is_from_net = False
elif ( int(sys.argv[2]) == 0 ):
    is_from_net = True
else:
    is_from_net = False

import sys
ticker = sys.argv[1]
sources = [                                                         \
    "https://concords.moneydj.com/z/zc/zca/zca_" + ticker + ".djhtm",
    "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "https://trade.ftsi.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "https://just2.entrust.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "https://stockchannelnew.sinotrade.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "https://moneydj.emega.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "https://stock.capital.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "https://fund.hncb.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "https://just.honsec.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "https://sjmain.esunsec.com.tw/z/zc/zca/zca_" + ticker + ".djhtm"
]
len_sources = len(sources)

DIR0="./datafiles/taiex/rs"

ofname = "ror." + datetime.today().strftime('%Y%m%d') + '.csv'
o_path = os.path.join(DIR0, ofname)

DIR1   = "./datafiles"
fname1 = "watchlist.20231023.txt"
path1  = os.path.join(DIR1, fname1)

use_plain_req = True

def source_factory(index, ticker):
    sources = [                                                         \
        "https://concords.moneydj.com/z/zc/zca/zca_" + ticker + ".djhtm", \
        "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://trade.ftsi.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://just2.entrust.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://stockchannelnew.sinotrade.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://moneydj.emega.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://stock.capital.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://fund.hncb.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://just.honsec.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://sjmain.esunsec.com.tw/z/zc/zca/zca_" + ticker + ".djhtm"
    ]
    seed = random.randint(0, len_sources-1)
    url = sources[seed]
    print("{0:04d} {1:02d} {2:s}".format(index, seed, url))
    return url

if ( is_from_net ):
    if ( use_plain_req ):
        with open(path1, 'r') as f:
            session = None; index = 1;
            for ticker in f:
                ticker = ticker.replace('\n','')
                url = source_factory(index, ticker)
                # @see https://stackoverflow.com/a/34491383
                # if you have to do just a few requests,
                # Otherwise you'll want to manage sessions yourself.
                try:
                    if session is None:
                        response = requests.get(url) # // TODO: connection pool instead
                        session = requests.Session()
                    else:
                        response = session.get(url)
                    # response.encoding = 'cp950'
                    time.sleep(1)
                    soup = BeautifulSoup(response.text, 'html.parser')
                    fname = "ror." + ticker + ".html"
                    path = os.path.join(DIR0, fname)
                    with open(path, "w") as outfile2:
                        outfile2.write(soup.prettify())
                        outfile2.close()
                except:
                    # traceback.format_exception(*sys.exc_info())
                    e = sys.exc_info()[0]
                    print("Unexpected error:", sys.exc_info()[0])
                    # raise
                finally:
                    index += 1
                    continue
        f.close()
        # urllib3 maintains a connection pool keyed by (hostname, port) pair
        sys.exit(0)
    else:
        browser = webdriver.Safari( \
            executable_path = '/usr/bin/safaridriver')
        browser.get(url)
        time.sleep(1)
        page1 = browser.page_source
        soup = BeautifulSoup(page1, 'html.parser')
        browser.quit()
else:
    with open(path) as q:
        soup = BeautifulSoup(q, 'html.parser')

# // FIXME: fetch name
# title = soup.find("meta",  {"name":"description"})
name = "n/a" #title["content"].split(' ')[0].split(')')[1].strip()

# // FIXME: parse ytd ror
r_ytd = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[8] \
    .find_all('td')[1].text.strip().replace('%', '')

r_1w  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[9] \
    .find_all('td')[1].text.strip().replace('%', '')

r_1m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[10] \
    .find_all('td')[1].text.strip().replace('%', '')

r_2m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[11] \
    .find_all('td')[1].text.strip().replace('%', '')

r_3m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[12] \
    .find_all('td')[1].text.strip().replace('%', '')

# olist =   [ f_1d,  f_1w, f_1m, "n/a", f_3m, f_6m,  f_1y,  f_ytd, f_3y  ]
olist   =   [ "n/a", r_1w, r_1m, r_2m,  r_3m, "n/a", "n/a", r_ytd, "n/a" ]
#print(olist)
# presume get_twse_ror.py is running at first
with open(o_path, 'a') as ofile:
    # ofile.write("ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y\n")
    ofile.write(ticker+":"+name+":n/a:"+r_1w+":"+r_1m+":"+r_2m+":"+r_3m \
        +":n/a:n/a:"+r_ytd+":n/a"+"\n")
    ofile.close()
sys.exit(0)

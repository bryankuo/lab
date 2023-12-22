#!/usr/bin/python3

# python3 fetch_ticker_ror.py
# fetch ticker ror html from broker, serving ror.sh
# rotating user agent
# \param in rs/yyyymmdd folder
# \param out ror.YYYYMMDD.csv, append, created by get_twse_ror.py
# \param out ror.[ticker].html
# return 0

import os, sys, requests, time, numpy, random, csv, timeit
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
from timeit import default_timer as timer
from datetime import timedelta, datetime
from pprint import pprint
sys.path.append(os.getcwd())
import useragents as ua
import sites # // TODO: as well as url

# twse history
# https://www.twse.com.tw/rwd/zh/TAIEX/MI_5MINS_HIST?date=20230701&response=html
# https://goodinfo.tw/tw/StockIdxDetail.asp?STOCK_ID=%E5%8A%A0%E6%AC%8A%E6%8C%87%E6%95%B8
# https://www.macromicro.me/charts/36436/tai-wan-gu-shi-da-pan-zhi-shu-bao-chou-lyu
# 臺灣加權指數與相關指數
# https://www.moneydj.com/iquote/iQuoteChart.djhtm?a=AI001059 ( works )

DIR0="./datafiles/taiex/rs"
DIR2 = os.path.join(DIR0, datetime.today().strftime('%Y%m%d'))

ofname = "ror." + datetime.today().strftime('%Y%m%d') + '.csv'
o_path = os.path.join(DIR0, ofname)

DIR1   = "./datafiles"
fname1 = "watchlist.txt"
path1  = os.path.join(DIR1, fname1)

ofname1 = "log.txt"
log_path = os.path.join(DIR2, ofname1)

conn_list = [1] * len(sites.list); conn = 0
def source_factory(ticker):
    # url = random.choice(sites.list) + page
    conn = random.randint(0, len(sites.list)-1)
    while ( conn_list[conn] <= 0 ):
        conn = random.randint(0, len(sites.list)-1)
    page = "/z/zc/zca/zca_" + ticker + ".djhtm"
    url = sites.list[conn] + page
    return url
    '''
    sources = [                                                         \
        "https://concords.moneydj.com/z/zc/zca/zca_" + ticker + ".djhtm", \
        # site is down "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://trade.ftsi.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://just2.entrust.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://stockchannelnew.sinotrade.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "http://moneydj.emega.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://stock.capital.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://fund.hncb.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://just.honsec.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://sjmain.esunsec.com.tw/z/zc/zca/zca_" + ticker + ".djhtm"
        # // TODO: to be verified
        # "https://kgieworld.moneydj.com/z/con_CSA.htm?A=1227"
        # "masterlink.com.tw"
        # "cathaysec.com.tw"
        # "www.yuanta.com.tw/eYuanta/Securities"
    ]
    seed = random.randint(0, len(sources)-1)
    url = sources[seed]
    '''
f = open(path1, 'r'); logf = open(log_path, 'w')
session = None; count = 0; fname = ""; path = ""

for ticker in f:
    ticker = ticker.replace('\n','')

    # // FIXME: try next site instead of pass, get them'll
    fetch_not_ok = True
    while fetch_not_ok:
        # adopting rotating can help mask your scraping
        # @see https://rb.gy/uu497g
        headers = {'User-Agent': random.choice(ua.list)}

        url = source_factory(ticker)
        # // TODO: update connectivity dynamically
        # ex. available = [1] assume all initially,
        # if connection error then update to 0, avoid repeating error
        # // TODO: sites.py

        # @see https://stackoverflow.com/a/34491383
        # if you have to do just a few requests,
        # Otherwise you'll want to manage sessions yourself.
        try:
            if session is None:
                # response = requests.get(url)
                response = requests.get(url, headers=headers)
                session = requests.Session()
            else:
                # response = session.get(url)
                response = session.get(url, headers=headers)
            # response.encoding = 'cp950'
            # time.sleep(1) # // FIXME: random time
            soup = BeautifulSoup(response.text, 'html.parser')
            fname = "ror." + ticker + ".html"
            path = os.path.join(DIR2, fname)
            with open(path, "w") as outfile2:
                outfile2.write(soup.prettify())
                outfile2.close()

        except requests.exceptions.ConnectionError:
            e = sys.exc_info()[0]
            print("Unexpected error:", sys.exc_info()[0])
            conn_list[conn] = 0
            raise

        except:
            # traceback.format_exception(*sys.exc_info())
            e = sys.exc_info()[0]
            print("Unexpected error:", sys.exc_info()[0])
            raise

        finally:
            # @see https://stackoverflow.com/a/50223400
            s = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')
            d = datetime.strptime(s, '%Y%m%d %H:%M:%S.%f').strftime('%s.%f')
            d_in_ms = int(float(d)*1000)
            # print(d_in_ms)
            # print(datetime.fromtimestamp(float(d)))
            ts = datetime.fromtimestamp(float(d))
            sz = os.path.getsize(path)
            msg = "{} {:04} {:4} {} {:>5} {}" \
                .format(ts, count, ticker, response.status_code, sz, url)
            print(msg)
            logf.write(msg+"\n") # // FIXME: scan fetch log
            if ( response.status_code <= 200 ):
                count += 1
                fetch_not_ok = False
                # break

# // @see https://stackoverflow.com/a/49253627
session.close();
f.close(); logf.close()
sys.exit(0)

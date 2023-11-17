#!/usr/bin/python3

# python3 fetch_ticker_ror.py
# fetch ticker ror html from broker, serving ror.sh
# rotating user agent
# \param in rs/yyyymmdd folder
# \param out ror.YYYYMMDD.csv, append, created by get_twse_ror.py
# \param out ror.[ticker].html
# return 0

import sys, requests, time, os, numpy, random, csv, timeit
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

user_agent_list = [
	'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36',
	'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
	'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Safari/605.1.15',
]
n_ua = len(user_agent_list)

DIR0="./datafiles/taiex/rs"
DIR2 = os.path.join(DIR0, datetime.today().strftime('%Y%m%d'))

ofname = "ror." + datetime.today().strftime('%Y%m%d') + '.csv'
o_path = os.path.join(DIR0, ofname)

DIR1   = "./datafiles"
fname1 = "watchlist.txt"
path1  = os.path.join(DIR1, fname1)

def source_factory(index, ticker):
    sources = [                                                         \
        "https://concords.moneydj.com/z/zc/zca/zca_" + ticker + ".djhtm", \
        "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://trade.ftsi.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://just2.entrust.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://stockchannelnew.sinotrade.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "http://moneydj.emega.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://stock.capital.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://fund.hncb.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://just.honsec.com.tw/z/zc/zca/zca_" + ticker + ".djhtm", \
        "https://sjmain.esunsec.com.tw/z/zc/zca/zca_" + ticker + ".djhtm"
    ]
    seed = random.randint(0, len(sources)-1)
    url = sources[seed]
    print("{0:04d} {1:02d} {2:s}".format(index, seed, url))
    return url

with open(path1, 'r') as f:
    session = None; index = 1;
    for ticker in f:
        ticker = ticker.replace('\n','')

        # adopting rotating can help mask your scraping
        # @see https://rb.gy/uu497g
        user_agent = random.choice(user_agent_list)
        headers = {'User-Agent': user_agent}
        print(user_agent)

        url = source_factory(index, ticker)
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
            time.sleep(1) # // FIXME: random time
            soup = BeautifulSoup(response.text, 'html.parser')
            fname = "ror." + ticker + ".html"
            path = os.path.join(DIR2, fname)
            with open(path, "w") as outfile2:
                outfile2.write(soup.prettify())
                outfile2.close()

        except requests.exceptions.ConnectionError:
            e = sys.exc_info()[0]
            print("Unexpected error:", sys.exc_info()[0])
            pass
            # // FIXME: try next site instead of pass, get them'll

        except:
            # traceback.format_exception(*sys.exc_info())
            e = sys.exc_info()[0]
            print("Unexpected error:", sys.exc_info()[0])
            # raise

        finally:
            index += 1
            continue

    # // TODO: test this @see https://stackoverflow.com/a/49253627
    session.close()

f.close()
sys.exit(0)
# urllib3 maintains a connection pool keyed by (hostname, port) pair

#!/usr/bin/python3

# python3 get_ticker_market_value.py [ticker] [yyyymmdd]
# scraping market value from file fetched ror html
# \param in      ticker
# \param in      yyyymmdd
# \param in out  ror.YYYYMMDD.csv, append, created by get_twse_market_value.py
# \param in      ror.yyyymmdd.csv 2nd line for twse ror
# \param in      ror.[ticker].html
# \param in      benchmark output from get_twse_market_value.py
# \param out     rs.YYYYMMDD.csv
# 市值單位:百萬
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
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
    print("usage: get_ticker_market_value.py [ticker] [yyyymmdd]")
    sys.exit(0)
ticker   = sys.argv[1]
yyyymmdd = sys.argv[2]

DIR00="./datafiles/taiex"
DIR0="./datafiles/taiex/rs"
DIR1 = os.path.join(DIR0, yyyymmdd)

fname = "ror." + ticker + ".html"
h_path = os.path.join(DIR1, fname)

# gen by scrap_market_value.sh, then append one line at a time
mktv_fname = "market_value." + yyyymmdd + ".csv"
m_path  = os.path.join(DIR00, mktv_fname)
q = open(h_path)
soup = BeautifulSoup(q, 'html.parser') # // FIXME: chinese encoding
# print( len(soup.findAll('table')) )
if ( len(soup.findAll('table')) != 5 ):
    print(" " + ticker + " no data, bypass") # // FIXME: filtered by fetching?
    sys.exit(0)

name = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[0] \
    .find_all('td')[1].text.split('(')[0].strip()
# print("{}".format(name))

# apply to src 1,2,3,4
mktv = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[6] \
    .find_all('td')[3].text.strip().replace('%', '').replace(',', '')
# print("{}".format(mktv))

ofile = open(m_path, 'a')
ofile.write(ticker+":"+name+":"+mktv+"\n")
ofile.close()

sys.exit(0)

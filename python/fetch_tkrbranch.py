#!/usr/bin/python3

# python3 fetch_tkrbranch.py [ticker] [net|file]
# scrap all branch by ticker.
#
# there are 2 steps, 1: from net, 2: scrap from file
#
# \param in ticker
# \param in 0 net 1 file
# \param out csv file(ticker,close,volume)
# // TODO: test if sites apply


list = [ # the most comprehensive site list in project
    "https://concords.moneydj.com",
    "https://trade.ftsi.com.tw", \
    "https://just2.entrust.com.tw", \
    "https://stockchannelnew.sinotrade.com.tw", \
    "http://moneydj.emega.com.tw", \
    "https://stock.capital.com.tw", \
    "https://fund.hncb.com.tw", \
    "https://just.honsec.com.tw", \
    "https://sjmain.esunsec.com.tw"

    # // TODO: to be verified
    # site: kgieworld.moneydj.com 個股基本資料
    # https://kgieworld.moneydj.com/z/con_CSA.htm?a=
    # "https://kgieworld.moneydj.com/z/con_CSA.htm?A=1227" # works

    # site: djinfo.cathaysec.com.tw 個股基本資料
    # "https://djinfo.cathaysec.com.tw/z/zc/zcx/ZCXNEWCATHAYSEC.djhtm?A="
    # https://www.cathaysec.com.tw/exclude_AL/market.aspx?btn=1-00-00&st=2330

    # sites: www.yuanta.com.tw 個股基本資料
    # "www.yuanta.com.tw/eYuanta/Securities" # howto? different?
    # https://www.yuanta.com.tw/eYuanta/Securities/Node/Index?MainId=00412&C1=2018040405227002&C2=2018040406827696&ID=2018040406827696&Level=2

    # "http://tcfhcsec.moneydj.com/z/zc/zco/zco0/zco0.djhtm" # works

    # sites: masterlink.com.tw 個股基本資料
    # "https://www.masterlink.com.tw/stock-individualinteractive" # different?
]

import sys, requests, datetime, time, numpy, random, csv, urllib
import os, errno
# import urllib.parse
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
# // TODO: if selenium, click anchor of 1st th
# of 1st tr of table CPHB1_gv, twice, to sort by ticker ascend
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint
from array import *
sys.path.append(os.getcwd())
import useragents as ua
import sites

if ( len(sys.argv) < 2 ):
    print("python3 fetch_tkrbranch.py [ticker] [net|file]")
    sys.exit(0)

tkr = sys.argv[1]

# src3: http get, histock https://histock.tw/stock/rank.aspx
# 44 pages, 3 parameters, m, d, and p.
# https://histock.tw/stock/rank.aspx?p=all

DIR0="./datafiles/taiex/branch"
# @see https://stackoverflow.com/a/16029908
try:
    os.makedirs(DIR0)
except OSError as exc:
    if exc.errno == errno.EEXIST and os.path.isdir(DIR0):
        pass

from_file = True
if ( int(sys.argv[2]) == 0 ):
    from_file = False

if ( from_file ):
    fname = yyyymmdd + '.html'
    path = os.path.join(DIR0, fname)
    print(path)
    fname0 = yyyymmdd + '.unsorted.csv'
    path0 = os.path.join(DIR0, fname0)
    print(path0)
    with open(path, 'r') as fp:
        soup = BeautifulSoup(fp, 'html.parser')
        rows = soup.find_all("table", {"id": "CPHB1_gv"})[0] \
            .find_all("tr")
        print("# rows: " + str(len(rows)))
        n_tickers = 0
        with open(path0, 'w') as outfile0:
            for i in range(1, len(rows)):
                row = rows[i]
                tds = row.find_all('td')
                tkr = tds[0].text.strip()
                close  = tds[2].text.strip()
                p_chg  = tds[4].text.strip() # // FIXME: "--"
                vol    = tds[11].text.strip().replace(',','')
                # @see https://www.twse.com.tw/downloads/zh/products/stock_cod.pdf
                if ( 4 == len(tkr) and 1101 <= int(tkr) and int(tkr) <= 9999 ):
                    # print( tkr + " " + vol )
                    outfile0.write( tkr + ":" + close + ":" + p_chg + ":" + vol + "\n" )
                    n_tickers += 1
            print("n_tickers: " + str(n_tickers))
            outfile0.close();
        fp.close();
else:
    page = "/z/zc/zco/zco_" + tkr + ".djhtm"
    # class="t01" id="oMainTable", file size is around 20k

    # url = "https://concords.moneydj.com" + page                        # works,
    # url = "https://trade.ftsi.com.tw" + page                           # works, test adding encoding cp950
    # url = "https://just2.entrust.com.tw" + page                        # works, plus adding encoding
    # url = "https://fubon-ebrokerdj.fbs.com.tw/z/zc/zco/zco_1103.djhtm" # works
    # "http://fubon-ebrokerdj.fbs.com.tw"                                # works
    # "https://fubon-ebrokerdj.fbs.com.tw",

    # url = "https://stockchannelnew.sinotrade.com.tw" + page            # works
    # url = st.list[4] + page                                            # works
    # url = sites.list[5] + page                                         # works
    # url = sites.list[6] + page                                         # works
    # url = sites.list[7] + page                                         # works
    # url = sites.list[8] + page                                         # works
    # url = sites.list[9] + page                                         # works
    # url = sites.list[10] + page                                        # works
    # url = sites.list[11] + page                                        # works
    # url = sites.list[12] + page                                        # works

    print(url)
    # response = requests.get(url)
    headers = {'User-Agent': random.choice(ua.list)}
    response = requests.get(url, headers=headers)
    response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    # fname = tkr + "." + datetime.today().strftime('%Y%m%d') + '.html'
    fname = tkr + '.html'
    path = os.path.join(DIR0, fname)
    print(path)
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()

sys.exit(0)
# rm -f datafiles/taiex/branch/????.html

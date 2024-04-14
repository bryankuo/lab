#!/usr/bin/python3

# python3 after_market.py [yyyymmdd] [net|file]
# scrap all volume by date.
#
# there are 2 steps, 1: from net, 2: scrap from file
#
# \param in yyyymmdd
# \param in 0 net 1 file
# \param out csv file(ticker,close,volume)
#

import sys, requests, datetime, time, numpy, random, csv, urllib
import os, errno
# import urllib.parse
from bs4 import BeautifulSoup
# // TODO: if selenium, click anchor of 1st th
# of 1st tr of table CPHB1_gv, twice, to sort by ticker ascend
from timeit import default_timer as timer
from datetime import timedelta, datetime
from pprint import pprint
from array import *
sys.path.append(os.getcwd())
import useragents as ua

if ( len(sys.argv) < 2 ):
    print("python3 after_market.py [yyyymmdd] [net|file]")
    sys.exit(0)

yyyymmdd = sys.argv[1]

# src3: http get, histock https://histock.tw/stock/rank.aspx
# 44 pages, 3 parameters, m, d, and p.
# https://histock.tw/stock/rank.aspx?p=all

DIR0="./datafiles/taiex/after.market"
# @see https://stackoverflow.com/a/16029908
try:
    os.makedirs(DIR0)
except OSError as exc:
    if exc.errno == errno.EEXIST and os.path.isdir(DIR0):
        pass

from_file     = True
if ( int(sys.argv[2]) == 0 ):
    from_file     = False

fname = yyyymmdd + '.html'
html_path = os.path.join(DIR0, fname)

if ( from_file ):
    # print(html_path)
    fname0 = yyyymmdd + '.price.desc.csv'
    path0 = os.path.join(DIR0, fname0)
    # print(path0)

    fname1 = yyyymmdd + '.all.columns.csv'
    path1 = os.path.join(DIR0, fname1)
    # print(path1)

    with open(html_path, 'r') as fp:
        soup = BeautifulSoup(fp, 'html.parser')
        rows = soup.find_all("table", {"id": "CPHB1_gv"})[0] \
            .find_all("tr")
        n_tickers = 0
        outfile0 = open(path0, 'w')
        outfile1 = open(path1, 'w')
        outfile1.write("{}:{}:{}:{}:{}:{}:{}:{}:{}:{}:{}:{}:{}\n" \
            .format( "代號","名稱","價格","漲跌","漲跌幅", \
                "周漲跌","振幅","開盤","最高","最低", \
                "昨收","成交量","成交值" ) )
        for i in range(1, len(rows)):
            row = rows[i]
            tds = row.find_all('td')
            tkr = tds[0].text.strip()
            nm = tds[1].text.strip()
            close  = tds[2].text.strip()
            chg  = tds[3].text.strip()
            p_chg  = tds[4].text.strip() # // FIXME: "--"
            wp_chg = tds[5].text.strip()
            amp = tds[6].text.strip()
            opn = tds[7].text.strip()
            hi  = tds[8].text.strip()
            low = tds[9].text.strip()
            mark = tds[10].text.strip()
            vol    = tds[11].text.strip().replace(',','')
            turn   = tds[12].text.strip().replace(',','')
            # @see https://www.twse.com.tw/downloads/zh/products/stock_cod.pdf
            if ( 4 == len(tkr) and 1101 <= int(tkr) and int(tkr) <= 9999 ):
                # print( tkr + " " + vol )
                outfile0.write( tkr + ":" + close + ":" + p_chg + ":" + vol + "\n" )
                outfile1.write("{}:{}:{}:{}:{}:{}:{}:{}:{}:{}:{}:{}:{}\n" \
                    .format( tkr,nm,close,chg,p_chg, \
                        wp_chg,amp,opn,hi,low, \
                        mark,vol,turn ) )
                n_tickers += 1
        # print("n_tickers: " + str(n_tickers) + "\n")
        outfile0.close(); outfile1.close();
    fp.close();
else:
    url = "https://histock.tw/stock/rank.aspx?p=all"
    # // TODO: "https://histock.tw/stock/rank.aspx?t=dt"
    # print(url)
    # response = requests.get(url)
    headers = {'User-Agent': random.choice(ua.list)}
    response = requests.get(url, headers=headers)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    # print(html_path)
    outfile2 = open(html_path, "w")
    outfile2.write(soup.prettify())
    outfile2.close()

sys.exit(0)

#!/usr/bin/python3

# python3 fetch_tkrbranch.py [ticker] [net|file]
# scrap all branch by ticker.
#
# there are 2 steps, 1: from net, 2: scrap from file
#
# \param in ticker
# \param in 0 net 1 file
# \param out csv file(ticker,close,volume)

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

# fname = tkr + "." + datetime.today().strftime('%Y%m%d') + '.html'
fname = tkr + '.html'
path = os.path.join(DIR0, fname)

bfname = tkr + '.b.csv'
bpath = os.path.join(DIR0, bfname)
ofb = open(bpath, 'w')

sfname = tkr + '.s.csv'
spath = os.path.join(DIR0, sfname)
ofs = open(spath, 'w')

from_file = True
if ( int(sys.argv[2]) == 0 ):
    from_file = False

if ( from_file ):
    print("from:")
    print(path)
    fp = open(path, 'r')
    soup = BeautifulSoup(fp, 'html.parser')
    rows = soup.find_all("table", {"id": "oMainTable", "class": "t01"})[0] \
        .find_all("tr")
    n_rows = len(rows)
    print("# rows: " + str(n_rows))
    # pprint(rows[8].text.replace('\n','')) # .replace(' ','')
    # print("#tds: {}".format(len(tds)))
    for i in range(7, n_rows):
        tds = rows[i].find_all('td')
        n_tds = len(tds)
        if ( n_tds == 10 ): # normal case, top 10 pairs but...not all
            b0 = tds[0].text.replace('\n','').replace(' ','')
            b1 = tds[1].text.replace('\n','').replace(' ','').replace(',','')
            b2 = tds[2].text.replace('\n','').replace(' ','').replace(',','')
            b3 = tds[3].text.replace('\n','').replace(' ','').replace(',','')
            b4 = tds[4].text.replace('\n','').replace(' ','')

            s0 = tds[5].text.replace('\n','').replace(' ','')
            s1 = tds[6].text.replace('\n','').replace(' ','').replace(',','')
            s2 = tds[7].text.replace('\n','').replace(' ','').replace(',','')
            s3 = tds[8].text.replace('\n','').replace(' ','').replace(',','')
            s4 = tds[9].text.replace('\n','').replace(' ','')

            ofb.write(b0+":"+b1+":"+b2+":"+b3+":"+b4+"\n")
            ofs.write(s0+":"+s1+":"+s2+":"+s3+":"+s4+"\n")
        else:
            print("tbd")
    ofb.close(); ofs.close()
    sys.exit(0)
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
    fp.close()
    print("to:")
    print(spath)
    print(spath)

else:
    page = "/z/zc/zco/zco_" + tkr + ".djhtm"
    # class="t01" id="oMainTable", file size is around 20k

    # "https://concords.moneydj.com" # na
    url = random.choice(sites.list)
    print(url) # // FIXME: possible market closed?
    # response = requests.get(url)
    headers = {'User-Agent': random.choice(ua.list)}
    response = requests.get(url, headers=headers)
    response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
    print(path)

sys.exit(0)
# rm -f datafiles/taiex/branch/????.html

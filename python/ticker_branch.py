#!/usr/bin/python3

# python3 ticker_branch.py [tkr] [net|file]
# scrap branch by tkr
# @see transaction.py branch.py chips.py br.py
# 券商分點買賣日報
# https://histock.tw/stock/branch.aspx?no=1101

# there are 2 steps, 1: from net, 2: scrap from file
#
# \param in tkr
# \param in 0 net 1 file
# \param out csv file(ticker,close,volume)
#

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

if ( len(sys.argv) < 2 ):
    print("python3 ticker_branch.py [tkr] [net|file]")
    sys.exit(0)

tkr = sys.argv[1]

# src3: http get, histock https://histock.tw/stock/rank.aspx
# 44 pages, 3 parameters, m, d, and p.
# https://histock.tw/stock/rank.aspx?p=all

DIR0="./datafiles/taiex/branch"
try:
    os.makedirs(DIR0)
except OSError as exc:
    if exc.errno == errno.EEXIST and os.path.isdir(DIR0):
        pass

from_file     = True
if ( int(sys.argv[2]) == 0 ):
    from_file     = False

# fname = tkr + "." + datetime.today().strftime('%Y%m%d') + '.html'
fname = tkr + '.html'
path = os.path.join(DIR0, fname)

bfname = tkr + '.b.csv'
bpath = os.path.join(DIR0, bfname)
ofb = open(bpath, 'w')

sfname = tkr + '.s.csv'
spath = os.path.join(DIR0, sfname)
ofs = open(spath, 'w')

if ( from_file ):
    print(path)
    fp = open(path, 'r')
    soup = BeautifulSoup(fp, 'html.parser')
    rows = soup \
        .find_all("table", {"class": "tb-stock tbChip tbHide"})[0] \
        .find_all('tr')
    if ( rows is None ):
        print("rows not found")
        sys.exit(0)
    ths = soup \
        .find_all("table", {"class": "tb-stock tbChip tbHide"})[0] \
        .find_all('th')

    b0 = ths[0].text.replace('\n','').replace(' ','')
    b1 = ths[1].text.replace('\n','').replace(' ','').replace(',','')
    b2 = ths[2].text.replace('\n','').replace(' ','').replace(',','')
    b3 = ths[3].text.replace('\n','').replace(' ','').replace(',','')
    b4 = ths[4].text.replace('\n','').replace(' ','')
    ofb.write("代號"+":"+b0+":"+b1+":"+b2+":"+b3+":"+b4+"\n")

    s0 = ths[5].text.replace('\n','').replace(' ','')
    s1 = ths[6].text.replace('\n','').replace(' ','').replace(',','')
    s2 = ths[7].text.replace('\n','').replace(' ','').replace(',','')
    s3 = ths[8].text.replace('\n','').replace(' ','').replace(',','')
    s4 = ths[9].text.replace('\n','').replace(' ','')
    ofs.write("代號"+":"+s0+":"+s1+":"+s2+":"+s3+":"+s4+"\n")

    n_rows = len(rows)
    # print("# rows: " + str(n_rows))
    for i in range(1, n_rows):
        tds = rows[i].find_all('td')
        n_tds = len(tds)
        if ( n_tds == 10 ): # normal case, top 10 pairs but...not all
            bno = tds[0].find_all('a')[0].get('href').strip() \
                .split('?')[1].split('=')[1].split('&')[0]
            b0 = tds[0].text.replace('\n','').replace(' ','')
            b1 = tds[1].text.replace('\n','').replace(' ','').replace(',','')
            b2 = tds[2].text.replace('\n','').replace(' ','').replace(',','')
            b3 = tds[3].text.replace('\n','').replace(' ','').replace(',','')
            b4 = tds[4].text.replace('\n','').replace(' ','')
            ofb.write(bno+":"+b0+":"+b1+":"+b2+":"+b3+":"+b4+"\n")

            sno = tds[5].find_all('a')[0].get('href').strip() \
                .split('?')[1].split('=')[1].split('&')[0]
            s0 = tds[5].text.replace('\n','').replace(' ','')
            s1 = tds[6].text.replace('\n','').replace(' ','').replace(',','')
            s2 = tds[7].text.replace('\n','').replace(' ','').replace(',','')
            s3 = tds[8].text.replace('\n','').replace(' ','').replace(',','')
            s4 = tds[9].text.replace('\n','').replace(' ','')
            ofs.write(sno+":"+s0+":"+s1+":"+s2+":"+s3+":"+s4+"\n")
        else:
            print("tbd")
    ofb.close(); ofs.close(); fp.close()
    print(bpath); print(spath)

else:
    url = "https://histock.tw/stock/branch.aspx?no="+tkr
    print(url)
    # response = requests.get(url)
    headers = {'User-Agent': random.choice(ua.list)}
    response = requests.get(url, headers=headers)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    fname = tkr + '.html'
    path = os.path.join(DIR0, fname)
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
    print(path)

sys.exit(0)

# previous day ( @see transaction.py )
# https://histock.tw/stock/branch.aspx?no=2015&from=20220502&to=20220502
# day off
# https://histock.tw/stock/branch.aspx?no=2015&from=20220501&to=20220501
# day: 30, ... 365
# from, to
# https://histock.tw/stock/branch.aspx?no=5011&day=30


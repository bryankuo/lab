#!/usr/bin/python3

# python3 fetch_tkrbranch.py [ticker] [net|file]
# scrap all branch by ticker.

# there are 2 steps, 1: from net, 2: scrap from file
#
# \param in ticker
# \param in 0 net 1 file
# \param out csv file(ticker,close,volume)

import sys, requests, datetime, time, random, csv, urllib
import numpy as np
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

gfname = "gini." + datetime.today().strftime('%Y%m%d') + '.csv'
gpath =  os.path.join(DIR0, gfname)

fname = tkr + '.html'
hpath = os.path.join(DIR0, fname)

bfname = tkr + '.b.csv'
bpath = os.path.join(DIR0, bfname)

sfname = tkr + '.s.csv'
spath = os.path.join(DIR0, sfname)

from_file = True
if ( int(sys.argv[2]) == 0 ):
    from_file = False

bg0 = []
sg0 = []

# @see https://shorturl.at/agtuT
#define function to calculate Gini coefficient
def gini(x):
    total = 0
    for i, xi in enumerate(x[:-1], 1):
        total += np.sum(np.abs(xi - x[i:]))
    return total / (len(x)**2 * np.mean(x))

if ( from_file ):
    ofb = open(bpath, 'w')
    ofs = open(spath, 'w')
    gf = open(gpath, 'a')
    print("from: {}".format(hpath))
    fp = open(hpath, 'r')
    soup = BeautifulSoup(fp, 'html.parser')
    rows = soup.find_all("table", {"id": "oMainTable", "class": "t01"})[0] \
        .find_all("tr")
    n_rows = len(rows)
    # print("# rows: " + str(n_rows))
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
            if 7 < i: # title
                bg0.append(float(b3))

            s0 = tds[5].text.replace('\n','').replace(' ','')
            s1 = tds[6].text.replace('\n','').replace(' ','').replace(',','')
            s2 = tds[7].text.replace('\n','').replace(' ','').replace(',','')
            s3 = tds[8].text.replace('\n','').replace(' ','').replace(',','')
            s4 = tds[9].text.replace('\n','').replace(' ','')
            if 7 < i:
                sg0.append(float(s3))

            ofb.write(b0+":"+b1+":"+b2+":"+b3+":"+b4+"\n")
            ofs.write(s0+":"+s1+":"+s2+":"+s3+":"+s4+"\n")
        else:
            print("tbd")
    ofb.close(); ofs.close(); fp.close()
    # print("to: {} {}".format(bpath, spath))
    g0 = gini(np.array(bg0))
    print("b {:0.3f} {}".format(g0, bg0))
    s0 = gini(np.array(sg0))
    print("s {:0.3f} {}".format(s0, sg0))
    # @see https://tinyurl.com/2p9c54t3
    cg0 = g0 - s0
    print("cg0 {:0.3f}".format(cg0))
    if ( cg0 < -0.2 or 0.2 < cg0 ):
        gf.write( "{:4}:{:0.3f}".format(tkr, cg0) + "\n" )
        print("assume in demand ( supply ): ".format(cg0))
        sys.stdout.write('\a')
        sys.stdout.flush()

else:

    # https://just.honsec.com.tw/z/zc/zco/zco0/zco0.djhtm?a=2615&b=9677&BHID=9600
    # https://just.honsec.com.tw/z/zc/zco/zco_2615_5.djhtm
    # a: ticker
    # b: branch
    # BHID: hq id
    # C: recent x day, selection item
    # D
    # e: start, ex.2023-12-11
    # f: end
    # Ver

    # page = "/z/zc/zco/zco_" + tkr + ".djhtm" # works
    c = 2 # recent 5, if not given is 0
    page = "/z/zc/zco/zco_" + tkr + "_" + str(c) + ".djhtm" # works
    # page = "/z/zc/zco/zco.djhtm?a="+tkr+"&c=5"
    # class="t01" id="oMainTable", file size is around 20k

    # "https://concords.moneydj.com" # na
    url = random.choice(sites.list) + page
    print(url)
    # response = requests.get(url)
    headers = {'User-Agent': random.choice(ua.list)}
    response = requests.get(url, headers=headers)
    response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    with open(hpath, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
    sz = os.path.getsize(hpath)
    msg = "{:4} {} {:>5} {} {}" \
        .format(tkr, response.status_code, sz, hpath, url)
    print(msg)

sys.exit(0)
# rm -f datafiles/taiex/branch/????.html
# rm -f ./datafiles/taiex/branch/????.[bs].csv

#
# note: 未計入自營商部份
# @see https://shorturl.at/cruP3
# 關於主力的定義是當天買賣超個股的前15名券商，因此並未計入自營商部份
# @see https://shorturl.at/gAN09


# @see https://shorturl.at/xNX18

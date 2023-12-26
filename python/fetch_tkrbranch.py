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
import os, errno, webbrowser, binascii
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
    sz = os.path.getsize(hpath)
    if ( sz < 20000 ):
        print("size issue, try another site")
        sys.exit(0)
    ofb = open(bpath, 'w')
    ofs = open(spath, 'w')
    gf = open(gpath, 'a')
    fp = open(hpath, 'r')
    soup = BeautifulSoup(fp, 'html.parser')
    rows = soup.find_all("table", {"id": "oMainTable", "class": "t01"})[0] \
        .find_all("tr")
    n_rows = len(rows)
    # print("# rows: " + str(n_rows))
    # pprint(rows[8].text.replace('\n','')) # .replace(' ','')
    # print("#tds: {}".format(len(tds)))

    i = 7
    # print(rows[i])
    # sys.exit(0)
    tds = rows[i].find_all('td')
    # print(tds)
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

    ofb.write("代號"+":"+b0+":"+b1+":"+b2+":"+b3+":"+b4+"\n")
    ofs.write("代號"+":"+s0+":"+s1+":"+s2+":"+s3+":"+s4+"\n")

    top1b_href = ""; top1s_href ="";
    N_FOOTER=3
    for i in range(8, n_rows-N_FOOTER):
        tds = rows[i].find_all('td')
        n_tds = len(tds)
        if ( n_tds == 10 ): # normal case, top 10 pairs but...not all
            b0 = tds[0].text.replace('\n','').replace(' ','')
            # print(tds[0])
            if ( 0 < len(b0) ):
                bbno = tds[0].find_all('a')[0].get('href').strip() \
                    .split('&')[1].split('=')[1].split('&')[0]
                l = len(bbno)
                if ( 4 < l and 16 == l ):
                    bbno1 = \
                        binascii.a2b_hex(bbno[ 2: 4]).decode("ascii") + \
                        binascii.a2b_hex(bbno[ 6: 8]).decode("ascii") + \
                        binascii.a2b_hex(bbno[10:12]).decode("ascii") + \
                        binascii.a2b_hex(bbno[14:16]).decode("ascii")
                    bbno = bbno1
                # else:
                #    print("{} bbno {}".format(i, bbno))
                if ( i == 8 ):
                    top1b_href = tds[0].find_all('a')[0].get('href').strip()
                b1 = tds[1].text.replace('\n','').replace(' ','').replace(',','')
                b2 = tds[2].text.replace('\n','').replace(' ','').replace(',','')
                b3 = tds[3].text.replace('\n','').replace(' ','').replace(',','')
                b4 = tds[4].text.replace('\n','').replace(' ','')
                bg0.append(float(b3))
                ofb.write(bbno+":"+b0+":"+b1+":"+b2+":"+b3+":"+b4+"\n")

            s0 = tds[5].text.replace('\n','').replace(' ','')
            if ( 0 < len(s0) ):
                if ( i == 8 ):
                    top1s_href = tds[5].find_all('a')[0].get('href').strip()

                sbno = tds[5].find_all('a')[0].get('href').strip() \
                    .split('&')[1].split('=')[1].split('&')[0]
                l = len(sbno)
                if ( 4 < l and 16 == l ):
                    sbno1 = \
                        binascii.a2b_hex(sbno[ 2: 4]).decode("ascii") + \
                        binascii.a2b_hex(sbno[ 6: 8]).decode("ascii") + \
                        binascii.a2b_hex(sbno[10:12]).decode("ascii") + \
                        binascii.a2b_hex(sbno[14:16]).decode("ascii")
                    sbno = sbno1
                # else:
                #    print("{} sbno {}".format(i, bbno))
                s1 = tds[6].text.replace('\n','').replace(' ','').replace(',','')
                s2 = tds[7].text.replace('\n','').replace(' ','').replace(',','')
                s3 = tds[8].text.replace('\n','').replace(' ','').replace(',','')
                s4 = tds[9].text.replace('\n','').replace(' ','')
                sg0.append(float(s3))
                ofs.write(sbno+":"+s0+":"+s1+":"+s2+":"+s3+":"+s4+"\n")
        else:
            print("{} {} tbd".format(i, len(rows[i].find_all('td'))))
    ofb.close(); ofs.close(); fp.close()
    # print("to: {} {}".format(bpath, spath))
    g0 = gini(np.array(bg0))
    # print("b {:0.3f} {}".format(g0, bg0))
    s0 = gini(np.array(sg0))
    # print("s {:0.3f} {}".format(s0, sg0))
    # @see https://tinyurl.com/2p9c54t3
    cg0 = g0 - s0
    print("{} recent 20d cg0 {:0.3f} [{:f}]".format(tkr, cg0, cg0))
    THRESHOLD = 0.197 # free will
    take_a_look = False
    if ( cg0 <= -THRESHOLD ):
        gf.write( "{:4}:{:0.3f}".format(tkr, cg0) + "\n" )
        print("assume in abundant supply: {}".format(cg0))
        take_a_look = True

    if ( THRESHOLD <= cg0 ):
        gf.write( "{:4}:{:0.3f}".format(tkr, cg0) + "\n" )
        print("assume in demand: ".format(cg0))
        print("href: {}".format(top1b_href))
        take_a_look = True

    if take_a_look :
        url = random.choice(sites.list) + top1s_href
        print(url)
        webbrowser.open(url)

        # url0 = "https://tw.stock.yahoo.com/quote/" + tkr + ".TWO/news"
        # "https://tw.stock.yahoo.com/quote/2313.TWO/news"
        # "https://tw.stock.yahoo.com/quote/2313.TW/announcement"
        # https://www.moneydj.com/kmdj/common/listnewarticles.aspx?svc=NW&a=TW.1102
        # type 5 n/a
        # print(url0)
        # webbrowser.open(url0)

        # @see announcement.py announcement_today.py
        yyy=str(int(datetime.today().strftime("%Y")) - 1911)
        criteria = {'co_id': tkr, 'step': 1, 'firstin': 'true', 'id': '', \
            'key': '', 'TYPEK': '', 'Stp': 4, 'go': 'false', \
            'keyWord': '', 'kewWord2': '', 'year': yyy, 'month1': 0, \
            'begin_day': 1, 'end_day': 1}
        url1 = "https://mops.twse.com.tw/mops/web/t51sb10_q1?" \
            + urllib.parse.urlencode(criteria)
        # url1 = "https://mops.twse.com.tw/mops/web/t51sb10_q1?co_id="+tkr+ \
        #    "&step=1&firstin=true&id&key&TYPEK&Stp=4&go=false&keyWord&kewWord2&year="+yyy+"&month1=0&begin_day=1&end_day=1"

        # selenium detach feature @see https://stackoverflow.com/a/51865955
        # chrome_options.add_experimental_option("detach", True)
        print(url1)
        webbrowser.open(url1)
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
    c = 4 # recent 20 days, to see if better together with single branch
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

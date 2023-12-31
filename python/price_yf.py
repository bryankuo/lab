#!/usr/bin/python3

# python3 price_yf.py
# fetch board holding from the net
# rotating user agent
# \param in watchlist
# \param out raw html
# \param out log
# return 0

import os, sys, requests, time, numpy, random, csv, timeit
from bs4 import BeautifulSoup
'''
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
'''
from timeit import default_timer as timer
from datetime import timedelta, datetime
from pprint import pprint
sys.path.append(os.getcwd())
import useragents as ua

# twse history
# https://www.twse.com.tw/rwd/zh/TAIEX/MI_5MINS_HIST?date=20230701&response=html
# https://goodinfo.tw/tw/StockIdxDetail.asp?STOCK_ID=%E5%8A%A0%E6%AC%8A%E6%8C%87%E6%95%B8
# https://www.macromicro.me/charts/36436/tai-wan-gu-shi-da-pan-zhi-shu-bao-chou-lyu
# 臺灣加權指數與相關指數
# https://www.moneydj.com/iquote/iQuoteChart.djhtm?a=AI001059 ( works )
if ( len(sys.argv) < 3 ):
    print("usage: price_yf.py [ticker] [net|file]")
    sys.exit(0)

ticker = sys.argv[1].upper()
# shuf -n N input > output
# @see https://stackoverflow.com/a/15065490

from_file = True if int(sys.argv[2]) == 1 else False

DIR0="./datafiles/usa/price"
yyyymmdd = datetime.today().strftime('%Y%m%d')
if not os.path.exists(DIR0):
    os.mkdir(DIR0)

fname = ticker + ".html"
path = os.path.join(DIR0, fname)


# pick_ua = random.randint(0, len(ua.list)-1)
pick_ua = 7 # // FIXME: exhr tag not found? small screen?
pick_ua = 0 # works
pick_ua = 6 # // FIXME: mobile phone?
pick_ua = 5 # works

fname1 = ticker + ".frag.ua" + str(pick_ua) + ".html"
path1 = os.path.join(DIR0, fname1)

def quote(soup):
    of = open(path1, "w")
    hdr = soup.find_all( "div", { "id": "quote-header-info" } )
    # of.write(soup.div.prettify()) # works
    # @see https://www.crummy.com/software/BeautifulSoup/bs4/doc/#output
    # of.write( hdr[0].prettify() ) # works
    # of.write( hdr[0].div.prettify() ) # works

    # output will follow user agent changes,
    # therefore by counting the sequence of div element
    mark_tag = None; exhr_tag = None
    if ( 0 < len(hdr) ):
        mark_tag = hdr[0] \
            .find_all( "div" )[13] \
            .find_all( "fin-streamer" )
        if ( 0 < len(mark_tag) ):
            of.write( mark_tag[0].prettify() )
            mark = float( mark_tag[0].text.strip() )
            print("mark {}".format(mark))

        of.write( "\n" )

        exhr_tag = hdr[0] \
            .find_all( "div" )[15] \
            .find_all( "fin-streamer" )
        if ( 1 < len(exhr_tag) ): # possible
            of.write( exhr_tag[1].prettify() )
            exhr = float( exhr_tag[1].text.strip() )
            print("exhr {}".format(exhr))
    of.close()
    # print("{} {} {}".format(len(hdr), len(mark_tag), len(exhr_tag)))

if ( from_file ):
    fp = open(path, 'r')
    soup = BeautifulSoup(fp, 'html.parser')
    quote(soup)
    fp.close()

else:
    session = None;
    # headers = {'User-Agent': random.choice(ua.list)}
    # // FIXME: yf do change according to ua type
    headers = {'User-Agent': ua.list[pick_ua]}

    # @see https://stackoverflow.com/a/34491383
    # if you have to do just a few requests,
    # Otherwise you'll want to manage sessions yourself.

    url = "https://finance.yahoo.com/quote/"+ticker+"?p="+ticker
    try:
        if session is None:
            # response = requests.get(url)
            response = requests.get(url, headers=headers)
            session = requests.Session()
        else:
            # response = session.get(url)
            response = session.get(url, headers=headers)
        # response.encoding = 'cp950'

        # time.sleep(1) # // FIXME: verify that yf have to wait?
        # should be ua issue

        soup = BeautifulSoup(response.text, 'html.parser')
        of = open(path, "w")
        of.write(soup.prettify())
        of.close()
        quote(soup)

    except requests.exceptions.ConnectionError:
        e = sys.exc_info()[0]
        print("Unexpected error:", sys.exc_info()[0])
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
        sz = os.path.getsize(path) #
        msg = "{} {:5} {} {} {:>5} {} {}" \
            .format(ts, ticker, response.status_code, path, sz, pick_ua, url) # fix ua
        print(msg)

    # // @see https://stackoverflow.com/a/49253627
    session.close()
sys.exit(0)

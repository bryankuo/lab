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
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint
from array import *

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

use_plain_req = True
req_get       = True
from_file     = True
if ( int(sys.argv[2]) == 0 ):
    from_file     = False

if ( use_plain_req ):
    if ( req_get == True ):
        if ( from_file ):
            fname = yyyymmdd + '.html'
            path = os.path.join(DIR0, fname)
            print(path)
            fname0 = yyyymmdd + '.csv'
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
                        #ratio  = '{:.4f}'. format(float(int(vol)/int(v_last)))
                        if ( 4 == len(tkr) ):
                            # print( tkr + " " + vol )
                            outfile0.write( tkr + ":" + close + ":" + p_chg + ":" + vol + "\n" )
                            n_tickers += 1
                    print("n_tickers: " + str(n_tickers))
                    outfile0.close();
                fp.close();
        else:
            url = "https://histock.tw/stock/rank.aspx?p=all"
            print(url)
            response = requests.get(url)
            # response.encoding = 'cp950'
            soup = BeautifulSoup(response.text, 'html.parser')
            fname = yyyymmdd + '.html'
            path = os.path.join(DIR0, fname)
            print(path)
            with open(path, "w") as outfile2:
                outfile2.write(soup.prettify())
                outfile2.close()
    else:
        '''
        # src2
        data = { "is_check": 1 }
        '''
        response = requests.post(url, data)
        soup = BeautifulSoup(response.text, 'html.parser')
else:
    try:
        browser = webdriver.Safari( \
            executable_path = '/usr/bin/safaridriver')
        if ( browser is None ):
            print("make sure safari automation enabled")
            sys.exit(3)
        url = sources[seed]
        # print(sources[seed])
        browser.implicitly_wait(20)
        browser.maximize_window()
        browser.switch_to.window(browser.current_window_handle)
        browser.get(url)
        # print("wait fully loaded ...")
        page1 = browser.page_source
        soup = BeautifulSoup(page1, 'html.parser')
        browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        browser.minimize_window()
        browser.quit()
    except (SessionNotCreatedException):
        print('make sure allow remote is on')
    except:
        # traceback.format_exception(*sys.exc_info())
        e = sys.exc_info()[0]
        print("Unexpected error:", sys.exc_info()[0])
        raise
    finally:
        olist = [ 0 ]
        print(olist)

sys.exit(0)
# could be 0
# sort by price descending
#

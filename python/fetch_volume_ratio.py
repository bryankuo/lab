#!/usr/bin/python3

# python3 fetch_volume_ratio.py [ticker]
# fetch volume ratio yesterday
#
# \param in ticker
#

import sys, requests, time, os, numpy, random, csv
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

# src1: more reusable than the others, plain request ok
# src2: histock?

sources = [ # the most comprehensive one                                             \
        # param 0: type 2, 1: type 4
    [   "https://concords.moneydj.com/z/zg/zg_B_0_0.djhtm",        \
        "https://concords.moneydj.com/z/zg/zg_B_1_0.djhtm" ],      \

    [   "http://jsjustweb.jihsun.com.tw/z/zg/zg_B_0_0.djhtm",      \
        "http://jsjustweb.jihsun.com.tw/z/zg/zg_B_1_0.djhtm" ],    \

        # FIXME: response.encoding = 'cp950' matters
    [   "https://trade.ftsi.com.tw/z/zg/zg_B_0_0.djhtm",           \
        "https://trade.ftsi.com.tw/z/zg/zg_B_1_0.djhtm"],          \

    [   "https://just2.entrust.com.tw/z/zg/zg_B_0_0.djhtm",        \
        "https://just2.entrust.com.tw/z/zg/zg_B_1_0.djhtm"],       \
        # 1,2,3,4,5,7,10,20,30 day rank, works on Saturday

    # not allowed, // TODO: how about http?
    [   "https://fubon-ebrokerdj.fbs.com.tw/z/zg/zg_B_0_0.djhtm",  \
        "https://fubon-ebrokerdj.fbs.com.tw/z/zg/zg_B_1_0.djhtm"],

    [   "https://stockchannelnew.sinotrade.com.tw/z/zg/zg_B_0_0.djhtm",  \
        "https://stockchannelnew.sinotrade.com.tw/z/zg/zg_B_1_0.djhtm"],

    [   "https://moneydj.emega.com.tw/z/zg/zg_B_0_0.djhtm",        \
        "https://moneydj.emega.com.tw/z/zg/zg_B_1_0.djhtm"],        \

    [   "https://stock.capital.com.tw/z/zg/zg_B_0_0.djhtm",        \
        "https://stock.capital.com.tw/z/zg/zg_B_1_0.djhtm"],        \

    [   "https://fund.hncb.com.tw/z/zg/zg_B_0_0.djhtm",        \
        "https://fund.hncb.com.tw/z/zg/zg_B_1_0.djhtm"],        \

    [   "https://just.honsec.com.tw/z/zg/zg_B_0_0.djhtm", \
        "https://just.honsec.com.tw/z/zg/zg_B_1_0.djhtm"], \

    [   "https://sjmain.esunsec.com.tw/z/zg/zg_B_0_0.djhtm", \
        "https://sjmain.esunsec.com.tw/z/zg/zg_B_1_0.djhtm"] \
]
len_sources = len(sources)
# print(len_sources)

DIR0="."

use_plain_req = True
req_get       = True
seed          = random.randint(0, len_sources-1)
url           = sources[seed][1]
print(url)
fname = "volume.ratio." + datetime.today().strftime('%Y%m%d') \
    + "." + str(seed) + '.html'
path = os.path.join(DIR0, fname)
print(path)

if ( use_plain_req ):
    if ( req_get == True ):
        response = requests.get(url)
        # response.encoding = 'cp950'
        soup = BeautifulSoup(response.text, 'html.parser')
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
        browser.get(url)
        time.sleep(2)
        page1 = browser.page_source
        soup = BeautifulSoup(page1, 'html.parser')
    except (SessionNotCreatedException):
        print('make sure allow remote is on')
    except:
        traceback.format_exception(*sys.exc_info())
        e = sys.exc_info()[0]
        print("Unexpected error:", sys.exc_info()[0])
        raise
    finally:
        browser.quit()

with open(path, "w") as outfile2:
    outfile2.write(soup.prettify())
    outfile2.close()
olist = [ 0 ]
print(olist)
sys.exit(0)

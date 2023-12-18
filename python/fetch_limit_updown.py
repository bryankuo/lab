#!/usr/bin/python3

# python3 fetch_limit_updown.py [up or down] [date] [tkr type] [from]
# \param up or down, 0:down 1:up
# \param date in YYYYMMDD // TODO:
# \param in type ticker type
# \param in from source
# \return html file
# return 0

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

# src1: plain request get ok
# https://tw.stock.yahoo.com/rank/change-up?exchange=ALL
# https://tw.stock.yahoo.com/rank/change-down?exchange=ALL

# src2: post with param, type 2, 4 seperated, @18:30
# https://pchome.megatime.com.tw/rank/sto0/ock05.html
# https://pchome.megatime.com.tw/rank/sto1/ock05.html
# https://pchome.megatime.com.tw/rank/sto0/ock06.html
# https://pchome.megatime.com.tw/rank/sto1/ock06.html

# src3: selenium, rich, organized server side data
# https://goodinfo.tw/tw2/StockList.asp?MARKET_CAT=智慧選股&INDUSTRY_CAT=漲停股
# https://goodinfo.tw/tw2/StockList.asp?MARKET_CAT=智慧選股&INDUSTRY_CAT=跌停股
#

# src4: one http get contains type 2 and 4
# https://histock.tw/stock/rank.aspx?m=4&d=1
# https://histock.tw/stock/rank.aspx?m=4&d=0
#

# src5: more reusable than the others, plain request ok, except
# https://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZG_AB.djhtm
# https://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZG_AC.djhtm
# 403 - Forbidden: Access is denied

# for each source, ther is a [ down 2, down 4, up 2, up 4 ] touple
sources = [                                                         \
        # param AC: down, AB: up
        # param 0: type 2, 1: type 4
        # param 0: last 1,2,3,4,5,7,10,20,30 day(s)
    [   "https://concords.moneydj.com/Z/ZG/ZG_AC_0_0.djhtm",        \
        "https://concords.moneydj.com/Z/ZG/ZG_AC_1_0.djhtm",        \
        "https://concords.moneydj.com/z/zg/zg_AB_0_0.djhtm",        \
        "https://concords.moneydj.com/z/zg/zg_AB_1_0.djhtm" ],      \
        # oMainTable ( 6, 11), 1st 2 row
        # //FIXME: there is no data for last trade day on Saturday

        # FIXME: response.encoding = 'cp950' matters
    [   "https://trade.ftsi.com.tw/z/zg/zg_ac_0_0.djhtm",           \
        "https://trade.ftsi.com.tw/z/zg/zg_ac_1_0.djhtm",           \
        "https://trade.ftsi.com.tw/z/zg/zg_ab_0_0.djhtm",           \
        "https://trade.ftsi.com.tw/z/zg/zg_ab_1_0.djhtm"],          \
        # oMainTable ( 6, 11)

    [   "https://just2.entrust.com.tw/z/zg/zg_ac_0_0.djhtm",        \
        "https://just2.entrust.com.tw/z/zg/zg_ab_1_0.djhtm",        \
        "https://just2.entrust.com.tw/z/zg/zg_ab_0_0.djhtm",        \
        "https://just2.entrust.com.tw/z/zg/zg_ab_1_0.djhtm"],       \
        # oMainTable ( 6, 7)
        # 1,2,3,4,5,7,10,20,30 day rank, works on Saturday

    [   "https://moneydj.emega.com.tw/z/ZG/ZG_AC_0_0.djhtm",        \
        "https://moneydj.emega.com.tw/z/ZG/ZG_AC_1_0.djhtm",        \
        "https://moneydj.emega.com.tw/z/ZG/ZG_AB_0_0.djhtm",        \
        "https://moneydj.emega.com.tw/z/zg/zg_AB_1_0.djhtm"]        \
        # oMainTable ( 6, 11)

    # selenium required
    #[   "https://www.esunsec.com.tw/tw-rank/z/ZG/ZG_AC.djhtm", \
    #    "https://www.esunsec.com.tw/tw-rank/z/ZG/ZG_AB.djhtm"], \

    # not allowed, // TODO: how about http?
    # https://fubon-ebrokerdj.fbs.com.tw/z/zc/zca/zca_2102.djhtm
    # http://fubon-ebrokerdj.fbs.com.tw/z/zc/zcl/zcl.djhtm?a=3680&b=2

    # 404 possible path mismatch, has room to improve
    # [   "https://english.honsec.com.tw/Content.Files/Securities.Files/ZG/ZG07.aspx", \
    #    "https://english.honsec.com.tw/z/zg/zg_AB_1_0.djhtm"] \
]
# // TODO: import sites instead

if ( len(sys.argv) < 4 ):
    print("usage: fetch_limit_updown.py [up or down] [date] [tkr type] [from]")
    sys.exit(0)
is_limit_up = True
direction = "up"
if ( int(sys.argv[1]) == 0 ):
    is_limit_up = False
    direction = "down"
fetch_date = sys.argv[2]
ticker_type = sys.argv[3]
from_src = sys.argv[4]

DIR0="datafiles/taiex/qfbs"

def select_src( limit_up, fetch_date, tkr_type, seed ):
    # print( "src " + str(seed) + ", date " + fetch_date \
    #    + ", limit_up " + str(limit_up) + ", type " + str(tkr_type) )
    return sources[seed-1][ 2*limit_up + tkr_type ]

fname = "limit." + direction + "." + fetch_date \
    + "." + ticker_type + "." + from_src + '.html'
path = os.path.join(DIR0, fname)

url = select_src( int(sys.argv[1]), fetch_date, int(ticker_type), int(from_src) )
use_plain_req = True
req_get       = True
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

fname = "limit." + direction + "." + fetch_date + "." \
    + ticker_type + "." + from_src + '.html'
path = os.path.join(DIR0, fname)
with open(path, "w") as outfile2:
    outfile2.write(soup.prettify())
    outfile2.close()
# s_from = str(from_src)
olist = [ url ]
print(olist)
sys.exit(0)

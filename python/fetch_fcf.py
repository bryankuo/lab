#!/usr/bin/python3

# python3 fetch_fcf.py [ticker]
# fetch cash flow statement by ticker
# \param in ticker
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
from datetime import timedelta, datetime
from pprint import pprint
from array import *

# src1:
# https://statementdog.com/analysis/3105/cash-flow-statement
# // TODO:
# src2:
# https://goodinfo.tw/tw2/StockList.asp?RPT_TIME=&MARKET_CAT=熱門排行&INDUSTRY_CAT=單季自由現金流入最多%40%40自由現金流量%40%40單季流入最多
#
# src3:
# https://tw.stock.yahoo.com/quote/1216.TW/cash-flow-statement
#
# src4:
# https://www.wantgoo.com/stock/2385/financial-statements/cash-flow
#
# src5:
# https://histock.tw/stock/financial.aspx?no=6294&st=7
#
if ( len(sys.argv) < 2 ):
    print("usage: fetch_fcf.py [ticker]")
    sys.exit(0)
ticker = sys.argv[1]
yyyy = sys.argv[2]
qq =  sys.argv[3]
tw_yyy = str(int(yyyy) - 1911)

DIR0="datafiles/taiex"
fname = "fcf." + ticker + '.html'
path = os.path.join(DIR0, fname)

if ( os.path.exists(path) ):
    os.remove(path) # clean up
use_plain_req = True
req_get       = False
if ( use_plain_req ):
    if ( req_get == True ):
        response = requests.get(url)
        # response.encoding = 'cp950'
        soup = BeautifulSoup(response.text, 'html.parser')
    else:
        data = { \
            "step": "1", \
            "firstin": "1", \
            "off": "1", \
           "queryName": "co_id", \
            "inputType": "co_id", \
            "TYPEK": "all", \
            "co_id": ticker, \
            "isnew": "false", \
            "year": tw_yyy, \
            "season": qq }

        url = "https://mops.twse.com.tw/mops/web/t164sb05"
        start = timer()
        response = requests.post(url, data)
        end = timer()
        print(timedelta(seconds=end-start))
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

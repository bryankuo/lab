#!/usr/bin/python3

# python3 fetch_cashflow_statement.py [ticker] [yyyy] [qq]
# fetch cash flow statement by ticker
# \param in ticker
# \return html file
# return 0

import sys, requests, time, os, numpy, random
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
# https://mops.twse.com.tw/mops/web/t164sb05
# fcf = ocf - capex

if ( len(sys.argv) < 4 ):
    print("usage: fetch_ocf.py [ticker] [yyyy] [qq]")
    sys.exit(0)
ticker = sys.argv[1]
yyyy = sys.argv[2]
qq =  sys.argv[3]
tw_yyy = str(int(yyyy) - 1911)

DIR0="datafiles/taiex"
fname = "cash.flow.statement." + ticker +".at." + yyyy + "." + qq + '.html'
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

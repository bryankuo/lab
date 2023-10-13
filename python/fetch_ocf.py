#!/usr/bin/python3

# python3 fetch_ocf.py [ticker]
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

# src1:
# https://mops.twse.com.tw/mops/web/t163sb20
# fcf = ocf - capex

if ( len(sys.argv) < 1 ):
    print("usage: fetch_ocf.py")
    sys.exit(0)

DIR0="datafiles/taiex"

def select_src( limit_up, fetch_date, tkr_type, seed ):
    print( "src " + str(seed) + ", date " + fetch_date \
        + ", limit_up " + str(limit_up) + ", type " + str(tkr_type) )
    return sources[seed-1][ 2*limit_up + tkr_type ]

fname = "ocf." + datetime.today().strftime('%Y%m%d') + '.html'
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
            "firstin": "true", \
            "TYPEK": "all", \
            "step": 1, \
            "funcName": "t163sb20", \
            "inputType": "keyword", \
            "off": 1, \
            "isQuery": "Y", \
            "year": "112", \
            "season": "02" }
        url = "https://mops.twse.com.tw/mops/web/t163sb20"
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

# fname = "ocf." + datetime.today().strftime('%Y%m%d') + '.html'
# path = os.path.join(DIR0, fname)
with open(path, "w") as outfile2:
    outfile2.write(soup.prettify())
    outfile2.close()
olist = [ 0 ]
print(olist)
sys.exit(0)

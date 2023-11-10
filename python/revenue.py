#!/usr/bin/python3

# python3 revenue.py
# scrap revenue
# playground on goodinfo scraping
#
# \param in
#

import sys, requests, datetime, time, os, numpy, random, csv, urllib
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

# filedate = sys.argv[1]

# f = { 'RANK' : '1' }
criteria = { 'RPT_TIME': '', 'MARKET_CAT': '熱門排行', \
    'INDUSTRY_CAT':
    '成交量增加張數–當日成交量與昨日比@@成交量增加張數@@當日成交量與昨日比', \
    'RANK': 1 }
# print(urllib.parse.urlencode(criteria)) # OK // TODO: append to asp
# @see https://stackoverflow.com/a/5607708
# @see https://www.urldecoder.org
# @see https://www.urlencoder.org

'''
+ urllib.parse.quote_plus(1)

urllib.parse.quote("http://www.sample.com/", safe="")
# print(sources[0])
print(urllib.parse.quote("http://www.sample.com/", safe=""))
sys.exit(0)
'''

sources = [
    # ok, default rank 0
    # selRANK
    # value 0 1 2 3 4
    "https://goodinfo.tw/tw2/StockList.asp?RPT_TIME=&MARKET_CAT=熱門排行&INDUSTRY_CAT=單月營收月增率%28本月份%29%40%40單月營收月增減率%40%40本月份月增率",
    "https://goodinfo.tw/tw2/StockList.asp?RPT_TIME=&MARKET_CAT=熱門排行&INDUSTRY_CAT=單月營收月增率%28本月份%29%40%40單月營收月增減率%40%40本月份月增率&RANK=1"
]

len_sources = len(sources)

DIR0="."

use_plain_req = False
req_get       = True
from_file     = True

if ( use_plain_req ):
    # if source 1
    # seed          = random.randint(0, len_sources-1)
    # url           = sources[seed][1]
    url = "https://histock.tw/stock/rank.aspx?p=all"
    print(url)
    fname = "after.market." + datetime.today().strftime('%Y%m%d') + '.html'
    path = os.path.join(DIR0, fname)
    print(path)
    if ( req_get == True ):
        response = requests.get(url)
        # response.encoding = 'cp950'
        soup = BeautifulSoup(response.text, 'html.parser')
        # src1 applies
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
        seed = 1
        if ( from_file ):
            fname = "revenue." + datetime.today().strftime('%Y%m%d') \
                + ".rank." + str(seed) + '.html'
            fname1 = "revenue." + datetime.today().strftime('%Y%m%d') \
                + ".rank." + str(seed) + '.csv'
            path = os.path.join(DIR0, fname)
            path1 = os.path.join(DIR0, fname1)
            print(path)
            print(path1)
            n_tickers = 0
            with open(path, "r") as infile0, open(path1, "w") as outfile0:
                soup = BeautifulSoup(infile0, 'html.parser')
                rows = soup.find_all("table", {"id": "tblStockList", \
                        "class": "r10 b1 p4_1"})[0].find_all("tr")
                # print(len(rows))
                 # the rank page could be not fully 300, ignoring etf
                for i in range(1, len(rows)):
                    row = rows[i]
                    tds = row.find_all('td')
                    rid = row.get('id')
                    seq = tds[0].text.strip()
                    tkr = tds[1].text.strip()
                    # url = tds[1].find_all('a')[0].get('href')
                    chg = tds[13].text.strip().replace(',','')
                    if ( rid != None and 4 == len(tkr) ):
                        print( seq + " " + tkr + " " + chg )
                        outfile0.write( seq + ":" + tkr + ":" \
                            + chg + "\n" )
                        n_tickers += 1
                        # for each page, row0 to 299
            print("n_tickers: " + str(n_tickers))
            infile0.close()
        else:
            browser = webdriver.Safari( \
                executable_path = '/usr/bin/safaridriver')
            if ( browser is None ):
                print("make sure safari automation enabled")
                sys.exit(3)
            url = sources[seed]
            print(sources[seed])
            browser.implicitly_wait(10)
            browser.maximize_window()
            browser.switch_to.window(browser.current_window_handle)
            browser.get(url)
            page1 = browser.page_source
            soup = BeautifulSoup(page1, 'html.parser')
            fname = "revenue." + datetime.today().strftime('%Y%m%d') \
                + ".rank." + str(seed) + '.html'
            path = os.path.join(DIR0, fname)
            print(path)
            with open(path, "w") as outfile2:
                outfile2.write(soup.prettify())
            outfile2.close()
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
        # time.sleep(1)
        # print("")
        olist = [ 0 ]
        print(olist)

sys.exit(0)



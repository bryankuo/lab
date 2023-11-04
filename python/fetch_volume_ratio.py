#!/usr/bin/python3

# python3 fetch_volume_ratio.py
# scrap volume ratio of last trade day
#
# \param in
#

import sys, requests, time, os, numpy, random, csv
import urllib.parse
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

# src3: histock?

# src1:  50, more reusable than the others, plain request ok
'''
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
'''

# src2: 300, https://goodinfo.tw/tw2/StockList.asp?RPT_TIME=&MARKET_CAT=熱門排行&INDUSTRY_CAT=成交量增加張數–當日成交量與昨日比%40%40成交量增加張數%40%40當日成交量與昨日比
'''
# page 1 rank 001 - 300, ok,
sources = [
    # 1.
    "https://goodinfo.tw/tw2/StockList.asp?RPT_TIME=&MARKET_CAT=%E7%86%B1%E9%96%80%E6%8E%92%E8%A1%8C&INDUSTRY_CAT=%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%BC%B5%E6%95%B8%E2%80%93%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94%40%40%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%BC%B5%E6%95%B8%40%40%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94"
]
'''

# f = { 'RANK' : '1' }
# page 2 rank 301 - 600
sources = [

    "https://goodinfo.tw/tw2/StockList.asp?RPT_TIME=&MARKET_CAT=%E7%86%B1%E9%96%80%E6%8E%92%E8%A1%8C&INDUSTRY_CAT=%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%BC%B5%E6%95%B8%E2%80%93%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94%40%40%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%BC%B5%E6%95%B8%40%40%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94",

'''
    "https://goodinfo.tw/tw2/StockList.asp?RPT_TIME=&MARKET_CAT=%E7%86%B1%E9%96%80%E6%8E%92%E8%A1%8C&INDUSTRY_CAT=%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%BC%B5%E6%95%B8%E2%80%93%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94%40%40%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%BC%B5%E6%95%B8%40%40%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94&STOCK_CODE=&RPT_TIME=%E6%9C%80%E6%96%B0%E8%B3%87%E6%96%99&STEP=DATA&RANK='+encodeURIComponent(selRANK.value)"
'''

"https://goodinfo.tw/tw2/StockList.asp?RPT_TIME=&MARKET_CAT=%E7%86%B1%E9%96%80%E6%8E%92%E8%A1%8C&INDUSTRY_CAT=%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%BC%B5%E6%95%B8%E2%80%93%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94%40%40%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%BC%B5%E6%95%B8%40%40%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94&STOCK_CODE=&RPT_TIME=%E6%9C%80%E6%96%B0%E8%B3%87%E6%96%99&STEP=DATA&RANK=1"
]

'''
+ urllib.parse.quote_plus(1)

urllib.parse.quote("http://www.sample.com/", safe="")
# print(sources[0])
print(urllib.parse.quote("http://www.sample.com/", safe=""))
sys.exit(0)
'''


'''
ReloadStockList('SEARCH_WORD=&SHEET=%E4%BA%A4%E6%98%93%E7%8B%80%E6%B3%81&SHEET2=%E8%BF%9112%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E4%B8%80%E8%A6%BD&MARKET_CAT=%E7%86%B1%E9%96%80%E6%8E%92%E8%A1%8C&INDUSTRY_CAT=%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%B9%85%E5%BA%A6%E2%80%93%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94%40%40%E6%88%90%E4%BA%A4%E9%87%8F%E5%A2%9E%E5%8A%A0%E5%B9%85%E5%BA%A6%40%40%E7%95%B6%E6%97%A5%E6%88%90%E4%BA%A4%E9%87%8F%E8%88%87%E6%98%A8%E6%97%A5%E6%AF%94&STOCK_CODE=&RPT_TIME=%E6%9C%80%E6%96%B0%E8%B3%87%E6%96%99&STEP=DATA&RANK='+encodeURIComponent(selRANK.value));

selRANK
value 0 1 2 3 4
'''


len_sources = len(sources)
# print(len_sources)

DIR0="."

use_plain_req = False
req_get       = True
from_file     = False

if ( use_plain_req ):
    seed          = random.randint(0, len_sources-1)
    url           = sources[seed][1]
    print(url)
    fname = "volume.ratio." + datetime.today().strftime('%Y%m%d') \
        + "." + str(seed) + '.html'
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
        seed = 0
        fname = "volume.ratio." + datetime.today().strftime('%Y%m%d') \
            + ".rank." + str(seed) + '.html'
        path = os.path.join(DIR0, fname)

        fname1 = "volume.ratio." + datetime.today().strftime('%Y%m%d') \
            + ".rank." + str(seed) + '.1.html'
        path1 = os.path.join(DIR0, fname1)

        print(path)
        if ( from_file ):
            with open(path) as fp:
                soup = BeautifulSoup(fp, 'html.parser')
            rows = soup.find_all("table", {"id": "tblStockList", \
                    "class": "r10 b1 p4_1"})[0].find_all("tr")
            # print(len(tables))
            print(len(rows))

            fname = "table." + datetime.today().strftime('%Y%m%d') \
                + ".rank." + str(seed) + '.html'
            path1 = os.path.join(DIR0, fname)
            '''
            with open(path1, "w") as outfile2:
                outfile2.write(tables[0].text)
                outfile2.close()
            '''
            fp.close()
            for i in range(1, len(rows)):
                row = rows[i]
                tds = row.find_all('td')
                rid = row.get('id')
                if ( rid != None ):
                    print(rid)
                # now row located // TODO: extract volume and write to csv file
            # need some time to parse
            # <table class="r10 b1 p4_1" id="tblStockList"
        else:
            browser = webdriver.Safari( \
                executable_path = '/usr/bin/safaridriver')
            if ( browser is None ):
                print("make sure safari automation enabled")
                sys.exit(3)
            url = sources[seed]
            # print(sources[seed])
            browser.implicitly_wait(20)
            browser.switch_to.window(browser.current_window_handle)
            browser.maximize_window()
            browser.get(url)
            page1 = browser.page_source
            soup = BeautifulSoup(page1, 'html.parser')
            # default rank 0
            with open(path, "w") as outfile2:
                outfile2.write(soup.prettify())
                outfile2.close()
            '''
            for selection in range( 1, 5 ):
                rank = Select(WebDriverWait(browser, 3)                           \
                    .until(EC.element_to_be_clickable(                            \
                        (By.XPATH,"//select[@id=\"selRANK\"]"))))
                rank.select_by_value(selection)
                time.sleep(6) # wait until page fully loaded
                page1 = browser.page_source
                soup = BeautifulSoup(page1, 'html.parser')
                fname = "volume.ratio." + datetime.today().strftime('%Y%m%d')     \
                    + ".rank." + str(selection) + '.html'
                path = os.path.join(DIR0, fname)
                print(path)
                with open(path, "w") as outfile2:
                    outfile2.write(soup.prettify())
                    outfile2.close()
                time.sleep(1)
            '''
            browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(1)

            sheet2 = Select(WebDriverWait(browser, 3)                     \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//select[@id='selSHEET2']"))))
            #print(sheet2)
            # print(sheet2.val)
            sheet2.select_by_value("近12日成交量一覽")

            rank = Select(WebDriverWait(browser, 3)                     \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//select[@id='selRANK']"))))
            print(rank)
            # rank.select_by_value("1")

            page1 = browser.page_source
            soup = BeautifulSoup(page1, 'html.parser')
            with open(path1, "w") as outfile2:
                outfile2.write(soup.prettify())
                outfile2.close()

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
        time.sleep(1)

olist = [ 0 ]
print(olist)
sys.exit(0)

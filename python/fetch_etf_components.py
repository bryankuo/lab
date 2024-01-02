#!/usr/bin/python3

# python3 fetch_eft_components.py [id] [net|file]
# fetch ticker ror from broker, serving ror.sh
# with selenium tips
# \param in id
# \param in 0: from internet, 1: from file
# \param out components.[id].[yyyymmdd].txt as bountylist.txt
# \param out components.[id].html
# return 0

import sys, requests, time, os, numpy, random, csv

# from raven import breadcrumbs # // FIXME:

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

if ( len(sys.argv) < 3 ):
    print("usage: fetch_eft_components.py [id] [net|file]")
    sys.exit(0)
ticker = sys.argv[1]
if ( int(sys.argv[2]) == 1 ):
    is_from_net = False
elif ( int(sys.argv[2]) == 0 ):
    is_from_net = True
else:
    is_from_net = False

import sys
etf_id = sys.argv[1]
sources = [ \
#
# url = "https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm?MSCI=0"

# moneydj
# 00733 holdings: more pages
# https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=00733.TW
# "https://www.moneydj.com/ETF/X/Basic/Basic0007A.xdjhtm?etfid=00733.TW"
# table id Repeater1

# https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=510880.SH

# multiple pages in one request,
# https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=00878.TW
#
# https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=0056.TW
"https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=0056.TW"
# etfid=1102

#
# one page, but not works
# https://www.wantgoo.com/stock/etf/00733/constituent
# https://www.wantgoo.com/stock/etf/00878/constituent
# https://www.wantgoo.com/stock/etf/0056/constituent
# https://www.wantgoo.com/stock/etf/00919/constituent
# https://www.wantgoo.com/stock/etf/0050/constituent
# https://www.wantgoo.com/stock/etf/00905/constituent
#    "https://www.wantgoo.com/stock/etf/" + etf_id + "/constituent" # // FIXME:

# https://www.wantgoo.com/stock/etf/ranking/fund-size
# https://www.wantgoo.com/stock/etf/ranking/fund-size?manager=國泰證券投資信託股份有限公司

# https://goodinfo.tw/tw/StockList.asp?MARKET_CAT=全部&INDUSTRY_CAT=ETF

# 國內基金持股資料
# https://www.yesfund.com.tw/w/wr/wr04.djhtm?a=AC0051
# https://www.tpex.org.tw/web/etf/etf_specification_domestic_detail.php?l=zh-tw&code=00928

# cmoney, works but don't understand
# https://www.cmoney.tw/etf/tw/00733/fundholding
# "https://www.cmoney.tw/etf/tw/" + etf_id + "/fundholding"

]

# DIR0="./datafiles/taiex"
DIR0 = "."
fname = "components." + etf_id + ".html"
path = os.path.join(DIR0, fname)
ofname = "components." + etf_id + "." + datetime.today().strftime('%Y%m%d') + '.txt'
o_path = os.path.join(DIR0, ofname)

use_plain_req = False
if ( is_from_net ):
    if ( os.path.exists(path) ):
        os.remove(path) # clean up
    url = sources[0]
    if ( use_plain_req ):
        response = requests.get(url)
        # response.encoding = 'cp950'
        soup = BeautifulSoup(response.text, 'html.parser')
    else:
        try:
            browser = webdriver.Safari( \
                executable_path = '/usr/bin/safaridriver')
            # browser.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS); # // FIXME:
            browser.implicitly_wait(20)
            browser.get(url)

            #headers = {
            #    "User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/117.0"
            #}
            # browser.get(url, headers=headers)

            # Select(WebDriverWait(browser, 5)                                \
                    #    .until(EC.visibilityOfAllElements())) # // FIXME:
            # // FIXME: wait until page fully loaded.

            # per_page = Select(WebDriverWait(browser, 10)                     \
            #    .until(EC.element_to_be_clickable(                          \
            #        (By.XPATH,"//tbody[@id='holdingTable']"))))

            # tbody = WebDriverWait(browser, 20) \
            #    .until(EC.presence_of_element_located( \
            # (By.ID, "holdingTable")))

            # tbody = browser.find_element_by_id("holdingTable")
            # print(len(tbody))
            # //*[@id="holdingTable"]

            #WebDriverWait(browser, 20) \
            #    .until(EC.visibility_of_element_located( \
            #(By.XPATH, "//*[@id=\"holdingTable\"]")))

            # WebDriverWait(browser, 20) \
            #    .until(EC.visibility_of_element_located( \
            # (By.XPATH, "/html/body/div[1]/main")))

            # WebDriverWait(browser, 20) \
            #    .until(EC.presence_of_element_located( \
            # (By.XPATH, "//*[@id=\"holdingTable\"]")))

            browser.switch_to.window(browser.current_window_handle) # OK
            browser.maximize_window() # OK

            time.sleep(2) # page - specific, check loading time

            page1 = browser.page_source
            soup = BeautifulSoup(page1, 'html.parser')
            # print(soup.find("tbody"))
        except (SessionNotCreatedException):
            print('make sure allow remote is on')
        # except (TimeoutException):
        #    print("timeout")
        except:
            # traceback.format_exception(*sys.exc_info()) # // FIXME:
            e = sys.exc_info()[0]
            print("Unexpected error:", sys.exc_info()[0])
            raise
        finally:
            browser.minimize_window()
            browser.quit()
            print("finally")
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
else:
    with open(path) as q:
        soup = BeautifulSoup(q, 'html.parser')

sys.exit(0)

#!/usr/bin/python3

# python3 price_type5.py [ticker] [yyyymmdd] [net|file]
# get ticker close price by date
# with selenium tips
# \param in ticker
# \param in date in yyyymmdd
# \param in 0: from internet, 1: from file
# \param out price.[ticker].[yyyymmdd].html
# \param out price.[ticker].[yyyymmdd].block.html
# \parm  out a list containing close price
# \return 0: success

import sys, requests, time, os
import urllib.request
from datetime import timedelta, datetime, date
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

# source
# 興櫃ㄧ般版個股歷史行情
# https://www.tpex.org.tw/web/emergingstock/historical/daily/EMdes010.php?l=zh-tw&f=EMdes010.20231006-C.csv
market = "https://shorturl.at/cmLZ8"

# https://www.tpex.org.tw/web/emergingstock/historical/daily/EMdcs002.php?l=zh-tw&f=EMdcs002.20231006-C.csv
blk_market = "https://shorturl.at/cswxU"
# // TODO: just highlight if any trade related to the ticker

# https://www.tpex.org.tw/web/emergingstock/single_historical/history.php?l=zh-tw
# // TODO: figure out how to get history

if ( len(sys.argv) < 4 ):
    print("usage: price_type5.py [ticker] [yyyymmdd] [net|file]")
    sys.exit(0)

ticker = sys.argv[1]
yyyymmdd = sys.argv[2]
if ( int(sys.argv[3]) == 1 ):
    is_from_net = False
elif ( int(sys.argv[3]) == 0 ):
    is_from_net = True
else:
    is_from_net = False
use_plain_req = False

DIR0="./datafiles/taiex" # consider compatible with rank.sh
fname = "price.type5."+yyyymmdd+".html"
fname1 = "price.type5."+yyyymmdd+".block.html"

path = os.path.join(DIR0, fname)
path1 = os.path.join(DIR0, fname1)

url = market
if ( is_from_net ):
    if ( os.path.exists(path) ):
        os.remove(path) # clean up
    # url = select_src( ticker, random.randint(1,4) )
    if ( use_plain_req ):
        response = requests.get(url)
        # response.encoding = 'cp950'
        soup = BeautifulSoup(response.text, 'html.parser')
    else:
        browser = webdriver.Safari( \
            executable_path = '/usr/bin/safaridriver')
        browser.get(url)
        time.sleep(1)
        per_page = Select(WebDriverWait(browser, 3)                     \
            .until(EC.element_to_be_clickable(                          \
                (By.XPATH,"//select[@name='EMdes010_result_length']"))))
        per_page.select_by_value("-1")
        time.sleep(1)
        page1 = browser.page_source
        soup = BeautifulSoup(page1, 'html.parser')
        with open(path, "w") as outfile2:
            outfile2.write(soup.prettify())
            outfile2.close()
        url = blk_market
        browser.get(url)
        time.sleep(1)
        per_page = Select(WebDriverWait(browser, 3)                     \
            .until(EC.element_to_be_clickable(                          \
                (By.XPATH,"//select[@name='EMdcs002_result_length']"))))
        per_page.select_by_value("-1")
        time.sleep(1)
        page1 = browser.page_source
        soup = BeautifulSoup(page1, 'html.parser')
        with open(path1, "w") as outfile2:
            outfile2.write(soup.prettify())
            outfile2.close()
        browser.quit()
else:
    with open(path) as q:
        soup = BeautifulSoup(q, 'html.parser')


close_price = 0
block_price = 0 # // TODO:
rows = soup.find_all("table", {"id": "EMdes010_result"})[0] \
    .find_all("tbody")[0].find_all("tr")

for tr in rows:
    tds = tr.findAll('td')
    this_ticker = tds[0].text.replace('\n','').strip()
    # print(this_ticker)
    if ( this_ticker == ticker ):
        if ( tds[10].text.replace(',', '').strip().isnumeric() ):
            close_price = float(tds[10].text.replace(',', '').strip())
            olist = [ close_price, block_price ]
        else:
            # no deal
            ask = float(tds[3].text.replace(',', '').strip())
            olist = [ ask, block_price ]
        break

print(olist)
sys.exit(0)

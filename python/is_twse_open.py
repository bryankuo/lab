#!/usr/bin/python3

# python3 is_twse_open.py [yyyymmdd]
# \param in date in yyyymmdd
# \param out 0: yes
# \param out yyyymmdd: no, and last trade day is yyyymmdd
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

# source 1
# https://www.twse.com.tw/pcversion/zh/page/trading/exchange/FMTQIK.html
#
# source 2
# https://www.twse.com.tw/rwd/zh/afterTrading/FMTQIK?date=20230901&response=html

if ( len(sys.argv) < 1 ):
    print("usage: is_twse_open.py [yyyymmdd]")
    sys.exit(0)

yyyymmdd = sys.argv[1]
use_plain_req = True

DIR0="./datafiles/taiex" # consider compatible with rank.sh
fname = "trade.days."+yyyymmdd+".html"
path = os.path.join(DIR0, fname)

url = "https://www.twse.com.tw/rwd/zh/afterTrading/FMTQIK?date="+yyyymmdd+"&response=html"

if ( os.path.exists(path) ):
    os.remove(path) # clean up
# url = select_src( ticker, random.randint(1,4) )
if ( use_plain_req ):
    response = requests.get(url)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()

else:
    browser = webdriver.Safari( \
        executable_path = '/usr/bin/safaridriver')
    browser.get(url)
    time.sleep(1)

    yr = Select(WebDriverWait(browser, 3)                     \
        .until(EC.element_to_be_clickable(                          \
            (By.XPATH,"//select[@name='yy']"))))
    yr.select_by_value(yyyymmdd[0:4])
    # time.sleep(1)

    mn = Select(WebDriverWait(browser, 3)                     \
        .until(EC.element_to_be_clickable(                          \
            (By.XPATH,"//select[@name='mm']"))))
    mn.select_by_value(yyyymmdd[4:6].lstrip("0"))
    # time.sleep(1)

    search =  WebDriverWait(browser, 3)                                \
        .until(EC.element_to_be_clickable(                          \
            (By.XPATH, '//button[text()="查詢"]')))
    search.click()
    # time.sleep(2)

    page1 = browser.page_source
    soup = BeautifulSoup(page1, 'html.parser')
    browser.quit()

prev_trade_day = None
date_to_search = date( \
    int(yyyymmdd[0:4]), int(yyyymmdd[4:6]), int(yyyymmdd[6:8]) )
rows = soup.find_all("tbody", {})[0].find_all("tr")
for tr in rows:
    tds = tr.findAll('td')
    dts = tds[0].text.replace('\n','').strip()
    this_date = date( int(dts[0:3])+1911, int(dts[4:6]), int(dts[7:9]) )
    if ( date_to_search == this_date ):
        olist = [ 0 ]
        break
    elif ( date_to_search < this_date ):
        olist = [ prev_trade_day.strftime('%Y%m%d') ]
        break
    else:
        prev_trade_day = this_date

print(olist)
sys.exit(0)

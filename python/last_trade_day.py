#!/usr/bin/python3

# python3 last_trade_day.py [yyyymmdd]
# get last trade day before or equal yyyymmdd by scraping
# generate trade days file of the month
# serving price.sh
#
# \param in date in yyyymmdd
# \param out yyyymmdd: the last trade day yyyymmdd
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

# 每日市場成交資訊
# source 1
# https://www.twse.com.tw/pcversion/zh/page/trading/exchange/FMTQIK.html
#
# source 2
# https://www.twse.com.tw/rwd/zh/afterTrading/FMTQIK?date=20230901&response=html
# // note, is grails is still under construction?
#
if ( len(sys.argv) < 1 ):
    print("usage: last_trade_day.py [yyyymmdd]")
    sys.exit(0)

yyyymmdd = sys.argv[1]
use_plain_req = True

DIR0="./datafiles/taiex" # consider compatible with rank.sh

fname = "trade.days."+yyyymmdd[0:6]+".html"
path = os.path.join(DIR0, fname)

fname1 = "trade.days."+yyyymmdd[0:6]+".txt"
path1 = os.path.join(DIR0, fname1)

fname0 = "trade.days."+yyyymmdd[0:6]+".html"
path0 = os.path.join(DIR0, fname0)

fname0a = "trade.days."+yyyymmdd[0:6]+".txt"
path0a = os.path.join(DIR0, fname0a)

url = "https://www.twse.com.tw/rwd/zh/afterTrading/FMTQIK?date=" \
    + yyyymmdd + "&response=html"
url0 = url

date_to_search = date( \
    int(yyyymmdd[0:4]), int(yyyymmdd[4:6]), int(yyyymmdd[6:8]) )
prev_day = date_to_search - timedelta(days=1)

if date_to_search.isoweekday() in ( 6, 7 ):
    if prev_day.isoweekday() in ( 6, 7 ):
        # date_to_search is Sunday
        prev_day = date_to_search - timedelta(days=2)
    else:
        # date_to_search is Saturday
        prev_day = date_to_search - timedelta(days=1)
else:
    # date_to_search is weekdays
    if ( date_to_search.isoweekday() == 1 ):
        # date_to_search is Monday
        prev_day = date_to_search - timedelta(days=3)
    else:
        # default case
        prev_day = date_to_search - timedelta(days=1)
# print(prev_day.strftime('%Y%m%d'))

if ( prev_day.month != date_to_search.month ) :
    url0 = "https://www.twse.com.tw/rwd/zh/afterTrading/FMTQIK?date=" \
        + prev_day.strftime('%Y%m')+ "01" + "&response=html"
    # rename
    fname0 = "trade.days."+prev_day.strftime('%Y%m')+".html"
    path0 = os.path.join(DIR0, fname0)
    fname0a = "trade.days."+prev_day.strftime('%Y%m')+".txt"
    path0a = os.path.join(DIR0, fname0a)
# print(url0)

soup = None; soup0 = None;
if ( use_plain_req ):
    response = requests.get(url)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
    if ( url0 != url ) :
        response0 = requests.get(url0)
        soup0 = BeautifulSoup(response0.text, 'html.parser')
        with open(path0, "w") as outfile2:
            outfile2.write(soup0.prettify())
            outfile2.close()

else:
    browser = webdriver.Safari( \
        executable_path = '/usr/bin/safaridriver')
    browser.maximize_window()
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
    browser.minimize_window()
    browser.quit()

if ( url0 != url ) :
    rows = soup0.find_all("tbody", {})[0].find_all("tr")
    # // TODO: update trading day for grep in price.sh
    with open(path0a, "w") as outfile2:
        for tr in rows:
            tds = tr.findAll('td')
            dts = tds[0].text.replace('\n','').strip()
            outfile2.write( str(int(dts[0:3])+1911) + \
                dts[4:6] + dts[7:9] + "\n" )
        outfile2.close()

rows = soup.find_all("tbody", {})[0].find_all("tr")
with open(path1, "w") as outfile2:
    for tr in rows:
        tds = tr.findAll('td')
        dts = tds[0].text.replace('\n','').strip()
        outfile2.write( str(int(dts[0:3])+1911) + \
            dts[4:6] + dts[7:9] + "\n" )
    outfile2.close()

olist = None
for tr in rows[::-1]:
    tds = tr.findAll('td')
    dts = tds[0].text.replace('\n','').strip()
    this_date = date( int(dts[0:3])+1911, int(dts[4:6]), int(dts[7:9]) )
    if ( date_to_search >= this_date ):
        olist = [ this_date.strftime('%Y%m%d') ]
        break
    else:
        continue

if ( olist is None ):
    rows0 = soup0.find_all("tbody", {})[0].find_all("tr")
    the_last = None
    for tr0 in rows0[::-1]:
        tds0 = tr0.findAll('td')
        dts0 = tds0[0].text.replace('\n','').strip()
        this_date = date( int(dts0[0:3])+1911, int(dts0[4:6]), int(dts0[7:9]) )
        if ( date_to_search >= this_date ):
            olist = [ this_date.strftime('%Y%m%d') ]
            break
        else:
            continue

print(olist)
sys.exit(0)

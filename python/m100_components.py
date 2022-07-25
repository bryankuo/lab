#!/usr/bin/python3

# python3 m100_components.py
# return 0
# 138:3406玉晶光:555.55
# source 8, 5 pages, top 150, update everyday, market value, rank
# use selenium, and firefox example:
# https://stackoverflow.com/a/36027884

import sys, requests, time, re
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException

try:
    # source 1: quote
    # https://pchome.megatime.com.tw/group/mkt5/cidE003_2.html
    # source 2: update daily
    # https://www.wantgoo.com/index/%5E543/stocks
    # source 3: with rank, monthly update
    # https://www.moneydj.com/ETF/X/Basic/Basic0007a.xdjhtm?etfid=0051.TW
    # source 4:
    # http://moneydj.emega.com.tw/js/T50_100.htm
    # source 5: weight rank daily update
    # https://www.cmoney.tw/etf/e210.aspx?key=0051
    # source 6: quote, daily update
    # https://histock.tw/global/globalclass.aspx?mid=0&id=3

    print( "排行:代號公司:權重%" )

    '''
    url = "https://www.cmoney.tw/etf/e210.aspx?key=0051"
    response = requests.get(url)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    print(soup.prettify())
    # rows = soup.find_all("table", {"class": "t01"})[0] \
    #    .find_all("tr")
    sys.exit(0)
    '''

    browser = webdriver.Safari( \
        executable_path = '/usr/bin/safaridriver')

    url = "https://www.cmoney.tw/etf/e210.aspx?key=0051"
    browser.get(url)
    time.sleep(5) # wait until page fully loaded ( or redirected )
    page = browser.page_source
    soup = BeautifulSoup(page, 'html.parser')
    browser.close()

    '''
    component_list = "a.txt"
    with open(component_list) as fp:
        soup = BeautifulSoup(fp, 'html.parser')
    '''

    rows = soup.find_all("table", {"class": "tb tb1"})[0] \
        .find_all("tr")
    index = 1
    for i in range(1, len(rows)):
        rank = str(index)
        ticker = rows[i].find_all('td')[0].text.strip()
        corp_name = rows[i].find_all('td')[1].text.strip()
        product = rows[i].find_all('td')[2].text.strip()
        weight = rows[i].find_all('td')[3].text.strip()
        if ( product != "股票" ):
            continue
        print( \
            rank + ":" + \
            ticker + corp_name + ":" + \
            weight )
        index += 1

except SessionNotCreatedException as ex:
    print(str(ex))
    print('make sure safari automation enabled.')
    browser.close()

finally:
    sys.exit(0)

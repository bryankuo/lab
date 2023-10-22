#!/usr/bin/python3

# python3 top150.py
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
    # soups = []
    browser = webdriver.Safari( \
        executable_path = '/usr/bin/safaridriver')
    '''
    component_list = "soups.txt"
    with open(component_list) as fp:
        soup = BeautifulSoup(fp, 'html.parser')
    '''
    print( "排行:代號公司:總市值(E)" )
    for i in range(1,6):
        # https://pchome.megatime.com.tw/rank/sto2/ock31_1.html
        url = 'https://pchome.megatime.com.tw/rank/sto2/'+ \
            'ock31_'+str(i)+'.html'
        # browser.set_page_load_timeout(5) # delay before browser open?
        browser.get(url)
        time.sleep(5) # wait until page fully loaded ( or redirected )
        page = browser.page_source
        soup = BeautifulSoup(page, 'html.parser')
        # soups.append(soup)
        tables = soup.find_all("div", {"id": "rank_table"})
        rows = soup.find_all("div", {"id": "rank_table"})[0] \
            .find_all("tr")
        for i in range(1, len(rows)):
            rank     = rows[i].find_all('td')[0].text.strip()
            tkr_name = rows[i].find_all('td')[1].text.strip()
            ticker = tkr_name[ \
                tkr_name.find("(")+1:tkr_name.find(")")]
            corp_name = \
                    tkr_name[0:tkr_name.find("(")].strip()
            pattern = re.compile(r'\s+')
            corp_name = re.sub(pattern, '', corp_name)
            mkt_value = rows[i].find_all('td')[2].text.strip()
            print( \
                rank + ":" + \
                ticker + corp_name + ":" + \
                mkt_value )
    browser.close()
    # for i in range(6):
    #    print(soups[i].prettify())

except SessionNotCreatedException as ex:
    print(str(ex))
    print('make sure safari automation enabled.')
    browser.close()

finally:
    sys.exit(0)

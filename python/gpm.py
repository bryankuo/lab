#!/usr/bin/python3

# python3 gpm.py [ticker]
# get gross profit margin
# return 0: success

import sys, requests, time, re
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

# https://mops.twse.com.tw/mops/web/t163sb09
# https://stock.wespai.com/p/19357
# https://www.cnyes.com/twstock/financial3.aspx
# ( preferred, both GPM and OPM are found )
# https://www.sinotrade.com.tw/Stock/Stock_3_1/Stock_3_1_7_6?ticker=2330
# https://www.yuanta.com.tw/eYuanta/securities/Node/Index?MainId=00412&C1=2018040407582803&C2=2018040401575421&ID=2018040401575421&Level=2&rnd=85237
# https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcr/zcr_6005.djhtm
# https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcr/zcr_3105.djhtm

ticker = sys.argv[1]
url = 'https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcr/zcr_' + ticker + '.djhtm'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
table = soup.find("table", {"id": "oMainTable"})
if ( table is None ):
    print('table not found')
    sys.exit(1)
# print(table.prettify())
quarters = table.find_all('tr')[2].text
print(quarters)
'''
answer = soup.findAll('table')[3].find_all('tr')[7].find_all('td')[5].text
'''
sys.exit(0)

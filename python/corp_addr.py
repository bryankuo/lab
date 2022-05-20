#!/usr/bin/python3

# python3 corp_addr.py
# return 0: sii 2,  otc 4, rotc 5, pub ?

import sys, requests, time, re
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

# ticker = sys.argv[1]
url = "https://mops.twse.com.tw/mops/web/ajax_t51sb01"
# sii, otc, rotc, pub
data = {                     \
    "subMenuID": "[2,2001]", \
    "step": 1,               \
    "firstin": 1,            \
    "TYPEK": "pub",          \
    "code": "" }

try:
    response = requests.post(url, data)
    soup = BeautifulSoup(response.text, 'html.parser')
    print(soup.prettify())
    sys.exit(0)

    corp_name = soup.findAll('span')[0].text
    # if ( corp_name is None ):
    #     print('not listed.')
    #    sys.exit(1)
    co_type = re.search('\(([^)]+)', corp_name).group(1)
    corp_name = corp_name.split('\n',1)[1]
    if ( co_type == "上市公司" ):
        ticker_type = 2
    elif ( co_type == "上櫃公司" ):
        ticker_type = 4
    elif ( co_type == "興櫃公司" ):
        ticker_type = 5
    else:
        # // TODO: others
        ticker_type = 3
    has_cb = soup.findAll('table')[1] \
        .find_all('tr')[1].find_all('td')[30].text
    cb_issue = soup.findAll('table')[1] \
        .find_all('tr')[1].find_all('th')[32].text
    cb = has_cb + cb_issue

    corp_title = soup.findAll('table')[1] \
        .find_all('tr')[1].find_all('td')[0].text

    hq_address = soup.findAll('table')[1] \
        .find_all('tr')[1] \
        .find_all('tr')[0].find_all('td')[0].text

    chairman = soup.findAll('table')[1] \
        .find_all('tr')[1] \
        .find_all('tr')[1].find_all('td')[0].text

    gm = soup.findAll('table')[1] \
        .find_all('tr')[1] \
        .find_all('tr')[1].find_all('td')[1].text

    olist = [ ticker, corp_name, ticker_type, co_type, cb, \
        corp_title, hq_address, chairman, gm ]
    print(olist)

except (IndexError):
    print('not listed.') # // TODO: grep listed file instead

sys.exit(0)

#!/usr/bin/python3

# python3 basic.py 2330
# return 0: listed 2,  otc 4, otcbb 5

import sys, requests, time, re
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = "https://mops.twse.com.tw/mops/web/ajax_t05st03"
data = { \
    "subMenuID": 1, "step": 1, "firstin": "true", \
    "off": "1", "keyword4": "", "code1": "", \
    "TYPEK2": "", "checkbtn": "", "queryName": "co_id", \
    "inputType": "co_id", "TYPEK": "all", \
    "co_id": ticker }
try:
    response = requests.post(url, data)
    soup = BeautifulSoup(response.text, 'html.parser')
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

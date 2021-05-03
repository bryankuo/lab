#!/usr/bin/python3

# python3 basic.py 2330
# return 0: listed, 1 otc, 2 otcbb, 3 public offering company

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
response = requests.post(url, data)
soup = BeautifulSoup(response.text, 'html.parser')
answer = soup.findAll('span')[0].text
if ( answer is None ):
    sys.exit(1)
co_type = re.search('\(([^)]+)', answer).group(1)
print( ticker + ": " + answer)
if ( co_type == "上市公司" ):
    ticker_type = 0
elif ( co_type == "上櫃公司" ):
    ticker_type = 1
elif ( co_type == "興櫃公司" ):
    ticker_type = 2
else:
    ticker_type =3
has_cb = soup.findAll('table')[1] \
    .find_all('tr')[1].find_all('td')[30].text
cb_issue = soup.findAll('table')[1] \
    .find_all('tr')[1].find_all('th')[32].text
print( has_cb + cb_issue )
sys.exit(ticker_type)

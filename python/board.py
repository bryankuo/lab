#!/usr/bin/python3

# python3 board.py 2330 [0|1]
# return 0: success
# pattern can be a list of keywords

import sys, requests, time, webbrowser, os
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup
from pprint import pprint

ticker = sys.argv[1]
if 3 <= len(sys.argv) :
    loading_page = False # caller 0: board_loop.sh or 1: uno_status.sh
else:
    loading_page = True  # caller: briefing.sh

storage = "datafiles/taiex/majority/"
if not os.path.exists(storage):
    os.mkdir(storage)

# https://mops.twse.com.tw/mops/web/stapap1_all
# board holdings, got valid data, until last month
# 5日,15日 @see shorturl.at/bcAG2
# url = "https://mops.twse.com.tw/mops/web/t51sb10_q1"
# "https://mops.twse.com.tw/mops/web/t05sr01_1#"
# https://www.iqvalue.com/Frontend/stock/shareholding?stockId=1519
# presume get at least one
for i in range(0, 3):
    the_day = datetime.today() + relativedelta(months=-i)
    month = str(int(the_day.strftime("%m"))) # latest, type 2, 4, 5 apply
    if ( month == 0 ):
        month = 12
        yr = str(int(the_day.strftime("%Y")) - 1911 - 1)
    else:
        yr = str(int(the_day.strftime("%Y")) - 1911)
    url = "https://mops.twse.com.tw/mops/web/ajax_stapap1" + \
        "?firstin=true&year=" + yr + "&month=" + month + \
        "&co_id=" + ticker + "&TYPEK=sii&step=0"
    response = requests.get(url)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    table = soup.find_all("table", {"class": "hasBorder"})
    rows = soup.select('.hasBorder tr')
    if ( 0 < len(rows) ):
        break

# to grep later @see majority.sh
outf0  = storage+ticker+'.'+yr+month+'.txt'
with open(outf0, "w") as outfile:
    for tr in rows:
        tds = tr.find_all('td')
        for td in tds:
            outfile.write(td.text.strip()+":")
        outfile.write('\n')
outfile.close()

if loading_page == True:
    webbrowser.open(url)

sys.exit(0)

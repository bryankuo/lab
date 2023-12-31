#!/usr/bin/python3

# python3 board.py [tkr] [0|1]
# get board holdings.
# \param in ticker
# \param in flag
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

# 董事、監察人、經理人及大股東持股餘額彙總表
# https://mops.twse.com.tw/mops/web/stapap1_all # step1
# post, 2 steps, detailed...

# type 2, 4
# https://www.iqvalue.com/Frontend/stock/shareholding?stockId=1519

# board holdings, got valid data, until last month
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

# https://goodinfo.tw/tw/StockHolderMeetingList.asp?MARKET_CAT=%E5%85%A8%E9%83%A8&INDUSTRY_CAT=%E5%85%A8%E9%83%A8&YEAR=%E8%BF%91%E6%9C%9F%E5%8F%AC%E9%96%8B

# 股東會時間明細表
# https://concords.moneydj.com/z/zu/zue/zuec/zuec_1_.djhtm

# 改選年度
# https://stock.wespai.com/equity

# 股東會時間地點
# https://www.kgi.com.tw/zh-tw/product-market/calendar-overview/shareholder-meetings

# history
# 召開股東常(臨時)會及受益人大會(94.5.5後之上市櫃/興櫃公司)
# https://mops.twse.com.tw/mops/web/t108sb16_q1
# 選舉事項：○無●有　改選本公司董事案
# /mops/web/ajax_t108sb16 post

# 採候選人提名制、累積投票制、全額連記法選任董監事及當選資料彙總表
# https://mops.twse.com.tw/mops/web/t144sb11

# 股東會議案決議情形
# https://mops.twse.com.tw/mops/web/t150sb04
# 4.董監事選舉


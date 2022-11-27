#!/usr/bin/python3

# python3 chips.py [ticker] [type]

import sys, requests, time, webbrowser
import urllib.request
from urllib.parse   import quote
from urllib.request import urlopen

from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker  = sys.argv[1]

if ( 3 <= len(sys.argv) ):
    co_type = int( sys.argv[2] )
    year  = datetime.today().strftime('%Y')
    month = datetime.today().strftime('%m')
    day   = datetime.today().strftime('%d')
    tday = year+month+day
    if ( co_type == 2 ) :
        # https://www.twse.com.tw/exchangeReport/FMSRFK?response=html&date=20220809&stockNo=1236
        monthly_turnaround = \
            "https://www.twse.com.tw/exchangeReport/FMSRFK?response=html&date=" \
            +tday+"&stockNo="+ticker
    elif ( co_type == 4 ) :
        # https://www.tpex.org.tw/web/stock/statistics/monthly/st44.php?l=zh-tw&code=3105
        monthly_turnaround = \
        "https://www.tpex.org.tw/web/stock/statistics/monthly/st44.php?l=zh-tw&code=" \
        + ticker
    else:
        monthly_turnaround = ""
else:
    monthly_turnaround = ""

# // FIXME
# major_holders = "https://tw.stock.yahoo.com/quote/"+ticker+".TW/major-holders"

ta = "https://invest.cnyes.com/twstock/TWS/"+ticker+"/technical"

histock_perf = "https://histock.tw/stock/"+ticker

institutional = \
    "https://www.wantgoo.com/stock/"+ticker+"/institutional-investors/trend"

holdings = \
    "https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcj/zcj_"+ticker+".djhtm"

fund = \
    "https://fubon-ebrokerdj.fbs.com.tw/z/zc/zc0/zc07/zc07_"+ticker+".djhtm"

g8bank = "https://histock.tw/stock/broker.aspx?no="+ticker
branch = "https://histock.tw/stock/branch.aspx?no="+ticker

# histock_chips = "https://histock.tw/stock/chips.aspx?no="+ticker
histock_chips = "https://histock.tw/stock/branch.aspx?no="+ticker+"&day=7"

share_outstanding = \
    "https://norway.twsthr.info/StockHolders.aspx?stock="+ticker

vol_profile = "https://www.esunsec.com.tw/tw-stock/z/zc/zcw/zcwg/zcwg.djhtm?id="+ticker

margin = "https://histock.tw/stock/chips.aspx?no="+ticker+"&m=mg"

urls = [ \
    # major_holders, \
    monthly_turnaround, \
    margin, \
    share_outstanding, \
    ta, \
    # histock_perf, \
    vol_profile, \
    institutional, \
    g8bank, \
    holdings, \
    fund, \
    histock_chips, \
    branch ]

i = 0
for url in urls:
    webbrowser.open(url)
    time.sleep(1)
    i += 1
    if ( i % 10 == 9 ):
        print('\a') # beep
        input("Press Enter to continue...")

sys.exit(0)
#!/usr/bin/python3

# python3 a905_component.py
# return 0

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

#
url = "https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm?MSCI=0"

# 00733 holdings: more pages
# https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=00733.TW
# https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=510880.SH
#
# one page
# https://www.wantgoo.com/stock/etf/00733/constituent
# https://www.wantgoo.com/stock/etf/00878/constituent
# https://www.wantgoo.com/stock/etf/0056/constituent
# https://www.wantgoo.com/stock/etf/00919/constituent
# https://www.wantgoo.com/stock/etf/0050/constituent
# https://www.wantgoo.com/stock/etf/00905/constituent

# https://www.wantgoo.com/stock/etf/ranking/fund-size
# https://www.wantgoo.com/stock/etf/ranking/fund-size?manager=國泰證券投資信託股份有限公司

# https://goodinfo.tw/tw/StockList.asp?MARKET_CAT=全部&INDUSTRY_CAT=ETF

response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
rows = soup.find_all("table", {})[2] \
        .find_all("tr")
index = 1
for i in range(3, len(rows)):
    rank      = str(index)
    tkr_name  = rows[i].find_all('td')[0].text.strip()
    mkt_value = rows[i].find_all('td')[1].text
    weight = rows[i].find_all('td')[2].text
    print( \
        rank + ":" + \
        tkr_name + ":" + \
        mkt_value + ":" + \
        weight )
    index += 1

sys.exit(0)

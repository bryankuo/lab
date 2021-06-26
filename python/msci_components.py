#!/usr/bin/python3

# python3 msci_components.py
# get listed daily average volume for one year
# return 0: not found, assume otc

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

# url_ftse50 = 'https://www.tpex.org.tw/web/stock/iNdex_info/gretai50/ingrid/r50cnstnt_result.php?l=zh-tw&d=110/04/16&s=0,asc,0&o=htm'
# url = 'https://www.taifex.com.tw/cht/9/futuresQADetail'
# url = 'https://www.yuantaetfs.com/#/FundWeights/1066'

# good to scrap
# url = "https://histock.tw/stock/taiexproportion.aspx"
url = "https://histock.tw/stock/mscitaiwan.aspx"
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
table = soup.find_all("table", {"id": "gv"})
if ( table is None ):
    sys.exit(1)
rows = table[0].select('tr')
if ( len(rows) <= 0 ):
    sys.exit(2)
for row in rows:
    tds = row.select('td')
    ths = row.select('th')
    if ( 0 < len(ths) ):
        ticker = ths[0].text.strip()
        co = ths[1].text.strip()
        qo = ths[2].text.strip()
        ch = ths[3].text.strip()
        pc = ths[4].text.strip()
        cap = ths[5].text.strip()
        wt = ths[6].text.strip()
    if ( 0 < len(tds) ):
        ticker = tds[0].text.strip()
        co = tds[1].text.strip()
        qo = tds[2].text.strip()
        ch = tds[3].text.strip()
        pc = tds[4].text.strip()
        cap = tds[5].text.strip()
        wt = tds[6].text.strip()
    print( \
        ticker, ":", \
        co, ":", \
        qo, ":", \
        ch, ":", \
        pc, ":", \
        cap, ":", \
        wt )
sys.exit(0)

#!/usr/bin/python3

# python3 volume.py 2330
# get listed daily average volume for one year
# return 0: not found, assume otc

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

# last 12 months
today = datetime.today()
last_day = ""; first_day = "";
n_rows = [None] * 12; months = []; avg_shares = [];

# url_ftse50 = 'https://www.tpex.org.tw/web/stock/iNdex_info/gretai50/ingrid/r50cnstnt_result.php?l=zh-tw&d=110/04/16&s=0,asc,0&o=htm'
# url = 'https://www.taifex.com.tw/cht/9/futuresQADetail'
# url = 'https://www.yuantaetfs.com/#/FundWeights/1066'

# good to scrap
# url = "https://histock.tw/stock/taiexproportion.aspx"
url = "https://histock.tw/stock/mscitaiwan.aspx"
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
print(soup.prettify())
sys.exit(3)
table = soup.select('table#tblStockList')
if ( table is None ):
    sys.exit(1)
rows = table.findAll('tr')
if ( len(rows) <= 0 ):
    sys.exit(2)
else:
    print( len(rows) )
sys.exit(0)

for i in range(0,12):
    n_rows[i] = 0; shares = 0
    url = 'https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=html&date=' + months[i] + '&stockNo=' + sys.argv[1]
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    table_body = soup.find('tbody')
    for tr in soup.findAll('tr')[2:]:
        tds = tr.findAll('td')
        shares += int(tds[1].text.replace(',', ''))
        n_rows[i] += 1
    if ( 0 < n_rows[i] ):
        shares /= n_rows[i];
        avg_shares.append(int(shares))
        print( "daily avg# shares for " + months[i] + \
                " is: " + "{:>10,}".format(avg_shares[i]))
    else:
        # possibly end of calculations
        print("no data for " + months[i])
        break
    time.sleep(3)
# // TODO: handle newly listed case, for example: 3413, prompt newly listed
print("----- for the past year :")
print( "daily avg# shares of " + sys.argv[1] + " is: "
    + "{:>10,}".format(int(sum(avg_shares)/len(avg_shares))))

sys.exit(0)

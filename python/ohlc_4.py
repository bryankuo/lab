#!/usr/bin/python3

# python3 ohlc_4.py [ticker]
# return outf0

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
outf0  = sys.argv[2]
index  = int(sys.argv[3])

row0 = ""
row1 = ""
# https://www.tpex.org.tw/web/stock/aftertrading/daily_trading_info/st43_print.php?l=zh-tw&d=111/08&stkno=3105&s=0,asc,0
url = 'https://www.tpex.org.tw/web/stock/aftertrading/daily_trading_info/st43_print.php?l=zh-tw' + \
    '&d=' + str(int(datetime.today().strftime("%Y"))-1911)+'/'+datetime.today().strftime("%m") + \
    '&stkno='+ticker+'&s=0,asc,0'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
table_body = soup.find('tbody')
if ( table_body is not None ):
    i = 0
    for tr in soup.findAll('tr')[2:]:
        tds = tr.findAll('td')
        if ( 9 == len(tds) ) :
            row0 =  row0 + tds[0].text.strip() + ":"
            row1 = row1 + str(float(tds[6].text.strip().replace(',', ''))) + ":"
    row0 = "ticker/date:"+row0[:-1]+"\n"
    row1 = ticker+":"+row1[:-1]+"\n"
    with open(outf0, 'a') as outfile:
        if ( index <= 1 ):
            outfile.write(row0)
        outfile.write(row1)
    outfile.close()
else:
    print("no data for " + ticker)

sys.exit(0)

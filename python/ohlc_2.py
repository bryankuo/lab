#!/usr/bin/python3

# python3 ohlc_2.py [ticker]
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
# https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=html&date=20220812&stockNo=1101
url = 'https://www.twse.com.tw/exchangeReport/STOCK_DAY?' + \
    'response=html&date=' + datetime.today().strftime("%Y%m%d") + \
    '&stockNo=' + ticker
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
table_body = soup.find('tbody')
if ( table_body is not None ):
    for tr in soup.findAll('tr')[2:]:
        tds = tr.findAll('td')
        row0 =  row0 + tds[0].text + ":"
        row1 = row1 + str(float(tds[6].text.replace(',', ''))) + ":"
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

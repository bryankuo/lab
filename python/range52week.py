#!/usr/bin/python3

# python3 range52week.py 2330
# get per, quote, chage, 52 week range
# return 0: success

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
# source 1
url = "https://concords.moneydj.com/z/zc/zca/zca.djhtm?a=" + ticker
# source 2
# https://concords.moneydj.com/z/zc/zca/zca_1101.djhtm
url = "https://concords.moneydj.com/z/zc/zca/zca_" + ticker + ".djhtm"
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
rows = soup.select('table .t01 tr')
# per = rows[3].select('td')[1].renderContents().decode("utf-8")
opn = float(rows[1].select('td')[1].renderContents())
quote = float(rows[1].select('td')[7].renderContents())
tds = rows[2].select('td')
low52 = float(tds[5].renderContents())
high52 = float(tds[3].renderContents())
spans= tds[1].select('span')
change = float(spans[0].renderContents()) / opn
# url1 = "https://tw.stock.yahoo.com/q/q?s=" + ticker
# response = requests.get(url1)
# soup = BeautifulSoup(response.text, 'html.parser')
# table = soup.find("table", {"border": 2, "width": 750})
# rows = table.select('tr')
# row = rows[1]
# tds = row.select('b')
# quote = float(tds[0].renderContents())
p_low52 = ( low52 - quote ) * 100 / quote
p_high52 = ( high52 - quote ) * 100 / quote
# per_string = ticker + " per: " + per
# print( per_string )
print( ticker + " quote: " + "{:>5.02f}".format(quote) + \
        ", chg: " + "{:>4.02f}".format(change*100) + "%" + \
    ", 52w range: " + \
    "{:>5.02f}".format(low52) + \
        " (" + "{:>5.02f}".format(p_low52) + "%) " + \
    " - " + \
    "{:>5.02f}".format(high52)+ \
        " (" + "{:>5.02f}".format(p_high52) + "%) ")
sys.exit(0)

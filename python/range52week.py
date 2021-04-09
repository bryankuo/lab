#!/usr/bin/python3

# python3 volume.py 2330
# get listed daily average volume for one year
# return 0: success, otherwise NG

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca.djhtm?a=" + ticker
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
rows = soup.select('table .t01 tr')
tds = rows[2].select('td')
low52 = float(tds[5].renderContents())
high52 = float(tds[3].renderContents())

url1 = "https://tw.stock.yahoo.com/q/q?s=" + ticker
response = requests.get(url1)
soup = BeautifulSoup(response.text, 'html.parser')
table = soup.find("table", {"border": 2, "width": 750})
rows = table.select('tr')
row = rows[1]
tds = row.select('b')
quote = float(tds[0].renderContents())

p_low52 = ( low52 - quote ) * 100 / quote
p_high52 = ( high52 - quote ) * 100 / quote
print( ticker + " quote: " + "{:>7.02f}".format(quote) + \
    ", 52 week range: " + \
    "{:>7.02f}".format(low52) + \
        " (" + "{:>5.02f}".format(p_low52) + "%) " + \
    " - " + \
    "{:>7.02f}".format(high52)+ \
        " (" + "{:>5.02f}".format(p_high52) + "%) ")
sys.exit(0)

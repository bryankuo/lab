#!/usr/bin/python3

# python3 gbank_activities.py [today|5|20|60|YTD]
# get government bank activities
# return 0: success

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
from pprint import pprint

ticker = sys.argv[1]
# source 1
# http://www.money-link.com.tw/stxba/imwcontent0.asp?page=hott3&ID=HOTT3&menusub=2&app=
url = "http://www.money-link.com.tw/stxba/imwcontent0.asp?page=hott3&ID=HOTT3&menusub=2&app="
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
table = soup.find_all("table", {})
# pprint(table)
row1 = soup.find_all("th", {"id": "HEAD1"})[2].renderContents().strip().decode("utf-8")
print(row1)

row0 = soup.findAll('tr')[24].text
print(row0)

row2 = soup.find_all("th", {"id": "HEAD1"})[2].text
pprint(row2)
row3 = soup.findAll('tr')[33].text #.renderContents().strip()
# .find_all('tr')[4].text
pprint(row3)
sys.exit(0)
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

'''
https://histock.tw/stock/broker.aspx?no=1217
broker8 = 'https://histock.tw/stock/broker8.aspx'
https://www.wantgoo.com/stock/public-bank/buy-sell
https://chart.capital.com.tw/Chart/TWII/TAIEX11.aspx
https://www.nta.gov.tw/singlehtml/67?cntId=nta_956_67
'''

sys.exit(0)

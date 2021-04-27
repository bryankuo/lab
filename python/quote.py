#!/usr/bin/python3

# python3 quote.py 2330
# return 0: not found, assume otc

import sys, requests, time, json, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

os.system('cls' if os.name == 'nt' else 'clear')
ticker = sys.argv[1]
# @see shorturl.at/elwzD
# https://mis.twse.com.tw/stock/api/getStockInfo.jsp?ex_ch=tse_9904.tw%7C&json=1&d=20210422&delay=0&_=1432626332924
url = 'https://mis.twse.com.tw/stock/api/getStockInfo.jsp?' + \
    'ex_ch=tse_' + ticker + '.tw%7C' + \
    '&json=1' + '&d=20210427&delay=0&_=1432626332924'
frame = requests.get(url).json()
# print(json.dumps(frame, indent=1))
yesterday = float(frame["msgArray"][0]["y"])
opn = float(frame["msgArray"][0]["o"])
high = float(frame["msgArray"][0]["h"])
low = float(frame["msgArray"][0]["l"])
# close = float(frame["msgArray"][0]["z"])
close = frame["msgArray"][0]["z"]
volume = frame["msgArray"][0]["v"]
h_limit = float(frame["msgArray"][0]["u"])
l_limit = float(frame["msgArray"][0]["w"])
asks = frame["msgArray"][0]["a"].split("_")
n_asks = frame["msgArray"][0]["f"].split("_")
bids = frame["msgArray"][0]["b"].split("_")
n_bids = frame["msgArray"][0]["g"].split("_")
print(ticker + " latest quote:")
print( \
    "     ystday: " + "{:<7.2f}".format(yesterday))
print( \
    "     open  : " + "{:<7.2f}".format(opn)+ \
    "     high  : " + "{:<.2f}".format(high)+ \
    "     low   : " + "{:<7.2f}".format(low) + \
    "     close : " + close)
#    "     close : " + "{:<7.2f}".format(close))
print( \
    "     h_lmt : " + "{:<7.2f}".format(h_limit) + \
    "     l_lmt : " + "{:<7.2f}".format(l_limit) + \
    "   vol   : " + volume + " lots")
print("     market depth:")
print("                 bid      ask" )
row = 0
for q in asks:
    print( "     " + \
    " " + "{:>7.0f}".format(float(n_bids[row])) + \
    " " + "{:>7.2f}".format(float(bids[row])) + \
    "    " + \
    "{:<7.2f}".format(float(q)) + \
    " " + "{:<7.0f}".format(float(n_asks[row])))
    row += 1
    if ( 5 <= row ):
        break
sys.exit(0)

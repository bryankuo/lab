#!/usr/bin/python3

# python3 quote.py 2330
# return 0: not found, assume otc

import sys, requests, time, json, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
from pprint import pprint

ticker = sys.argv[1]

raw_list = []
list2 = []
list4 = []
list5 = []

f = open("datafiles/listed_2.txt", "r")
raw_list = f.readlines()
for element in raw_list:
    list2.append(element.strip())

raw_list.clear()
f = open("datafiles/listed_4.txt", "r")
raw_list = f.readlines()
for element in raw_list:
    list4.append(element.strip())

raw_list.clear()
f = open("datafiles/listed_5.txt", "r")
raw_list = f.readlines()
for element in raw_list:
    list5.append(element.strip())

if ticker in list2:
    # print("tse_")
    list_type = "tse_"
elif ticker in list4:
    # print("otc_")
    list_type = "otc_"
elif ticker in list5:
    # print("not support") # // TODO: find quote API
    list_type = "tpex_"
else:
    print("not listed")
    sys.exit(0)

if ( list_type == "tse_" or list_type == "otc_" ):
    # @see shorturl.at/elwzD
    # @see https://zys-notes.blogspot.com/2020/01/api.html
    # https://mis.twse.com.tw/stock/api/getStockInfo.jsp?ex_ch=tse_9904.tw%7C&json=1&d=20210422&delay=0&_=1432626332924
    url = 'https://mis.twse.com.tw/stock/api/getStockInfo.jsp?' + \
        'ex_ch=' + list_type + ticker + '.tw%7C' + \
        '&json=1' + '&d=20220209&delay=0&_=1432626332924'
    # print(url)
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

    if ( frame["msgArray"][0]["pz"] == '-' ):
        strike_s = frame["msgArray"][0]["pz"]
        if ( len(asks) > 0 ):
            strike_s = "{:<04.2f}".format(float(asks[0]))
        else:
            print(len(bids))
    else:
        strike = float(frame["msgArray"][0]["pz"])
        strike_s = "{:<04.2f}".format(strike)
elif ( list_type == "tpex_" ):
    # // TODO: TPEX
    # url = "https://www.tpex.org.tw/web/emergingstock/lateststats/new.htm?l=zh-tw"
    url = "https://www.tpex.org.tw/storage/emgstk/ch/new.csv?t=1645506923059"
    response = requests.get(url)
    response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    # print(soup.prettify())
    text = soup.get_text()      # @see https://cutt.ly/zPOUnnY
    table = text.split('\r\n')  # @see https://stackoverflow.com/q/53071858
    del table[-4:]              # @see https://stackoverflow.com/a/15715924
    del table[:3]
    matching = [s for s in table if ticker in s]    # @see https://stackoverflow.com/a/4843172
    # pprint(matching[0]) # assume one item
    quotes = matching[0].split(',')
    typ = quotes[13]
    bid = quotes[3]
    ask = quotes[5]
    deal = quotes[12]
    if ( len(deal) > 1 ):
        strike_s = deal.strip('"')
    else:
        # // TODO: refine
        if ( typ == "買進" ):
            strike_s = bid.strip('"')
        elif ( typ == "賣出" ):
            strike_s = ask.strip('"')
        else:
            strike_s = ask.strip('"')
else:
    print("not support.")
    sys.exit(0)

olist = [ strike_s ]
print(olist)

sys.exit(0)

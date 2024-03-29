#!/usr/bin/python3

# python3 quote.py [ticker] [type]
# get instant quote
# return 0: not found, assume otc
#
# // TODO: instant quote for type 2, 4 @see https://histock.tw/stock/rank.aspx?p=all
#
import sys, requests, time, json, os, calendar, random
import urllib.request
import urllib.parse
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
sys.path.append(os.getcwd())
import useragents as ua
# from pprint import pprint

DIR0="./datafiles/taiex"

if ( len(sys.argv) < 2 ):
    print("python3 quote.py [ticker] [type]")
    sys.exit(0)

# serving uno_status.sh uno_quotes.sh
ticker = sys.argv[1]
l_type = sys.argv[2]

if l_type == "2" :
    list_type = "tse_"
elif l_type == "4" :
    list_type = "otc_"
elif l_type == "5" :
    # print("not support") # // TODO: find quote API
    list_type = "tpex_"
else:
    list_type = "tse_"

if ( list_type == "tse_" or list_type == "otc_" ):
    # @see shorturl.at/elwzD
    # @see https://zys-notes.blogspot.com/2020/01/api.html
    # https://mis.twse.com.tw/stock/api/getStockInfo.jsp?ex_ch=tse_9904.tw%7C&json=1&d=20210422&delay=0&_=1432626332924

    stamp = calendar.timegm(time.gmtime())
    criteria = { 'ex_ch': list_type + ticker + '.tw|', \
        'json': 1, 'd': '20231110', 'delay': 0, \
        # @see https://stackoverflow.com/a/4548711
        '_': stamp } # 1432626332924
    # print(urllib.parse.urlencode(criteria))
    # @see https://stackoverflow.com/a/5607708
    # @see https://www.urldecoder.org
    # @see https://www.urlencoder.org

    url0 = 'https://mis.twse.com.tw/stock/api/getStockInfo.jsp?'
    url = url0 + urllib.parse.urlencode(criteria)
    # frame = requests.get(url).json() # OK
    headers = {'User-Agent': random.choice(ua.list)}
    frame = requests.get(url, headers=headers).json()

    dump_frame = True
    if ( dump_frame ):
        # fname0 = "quote." + ticker + '.' + str(stamp) + '.txt'
        fname0 = "quote.txt"
        path0 = os.path.join(DIR0, fname0)
        print("write to {}".format(path0))
        with open(path0, 'w') as outfile0:
            # print(json.dumps(frame, indent=1))
            # utf-16 @see https://stackoverflow.com/a/18337754
            outfile0.write(json.dumps(frame, indent=1, ensure_ascii=False))
        outfile0.close()

    yesterday = float(frame["msgArray"][0]["y"])
    # print( frame["msgArray"][0]["n"] ) # OK
    if ( frame["msgArray"][0]["o"] != '-' ):
        opn = float(frame["msgArray"][0]["o"])

    if ( frame["msgArray"][0]["h"] != '-' ):
        high = float(frame["msgArray"][0]["h"])

    if ( frame["msgArray"][0]["l"] != '-' ):
        low = float(frame["msgArray"][0]["l"])

    close_s = frame["msgArray"][0]["z"]
    volume = frame["msgArray"][0]["v"]
    limit_h = float(frame["msgArray"][0]["u"])
    limit_l = float(frame["msgArray"][0]["w"])
    asks = frame["msgArray"][0]["a"].split("_")
    n_asks = frame["msgArray"][0]["f"].split("_")
    bids = frame["msgArray"][0]["b"].split("_")
    n_bids = frame["msgArray"][0]["g"].split("_")

    if ( frame["msgArray"][0]["pz"] != '-' ):
        # normal
        if ( frame["msgArray"][0]["z"].isnumeric() ):
            strike = float(frame["msgArray"][0]["z"]) # // FIXME:
            strike_s = "{:<04.2f}".format(strike)
        else:
            strike_s = close_s                        # // test
    else:
        strike_s = frame["msgArray"][0]["pz"]
        # print(str(len(bids))+','+str(len(asks)))
        if ( len(bids) <= 0 ):
            strike_s = "{:<04.2f}".format(float(asks[0]))
        elif ( len(asks) <= 0 ):
            strike_s = "{:<04.2f}".format(float(bids[0]))
        elif ( frame["msgArray"][0]["z"] != '-' ):
            strike_s = "{:<04.2f}".format(float(frame["msgArray"][0]["z"]))
        elif ( len(bids) > len(asks) ):
            strike_s = "{:<04.2f}".format(float(bids[0]))
        elif ( len(bids) < len(asks) ):
            strike_s = "{:<04.2f}".format(float(asks[0]))
        else:
            # strike_s = "{:<04.2f}".format(opn)
            strike_s = asks[0] # // FIXME: testing

elif ( list_type == "tpex_" ):
    # // TODO: TPEX
    # url = "https://www.tpex.org.tw/web/emergingstock/lateststats/new.htm?l=zh-tw"
    # url = "https://www.tpex.org.tw/storage/emgstk/ch/new.csv?t=1645506923059"
    url0 = "https://www.tpex.org.tw/storage/emgstk/ch/new.csv?"
    criteria = { \
        't': calendar.timegm(time.gmtime()) } # 1645506923059
    url = url0 + urllib.parse.urlencode(criteria)
    # response = requests.get(url)
    headers = {'User-Agent': random.choice(ua.list)}
    response = requests.get(url, headers=headers)
    response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    text = soup.get_text()      # @see https://cutt.ly/zPOUnnY
    table = text.split('\r\n')  # @see https://stackoverflow.com/q/53071858
    del table[-4:]              # @see https://stackoverflow.com/a/15715924
    del table[:3]
    # @see https://stackoverflow.com/a/4843172
    matching = [s for s in table if ticker in s]
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

# olist = [ strike_s ]
# olist = [ "{:>4.02f}".format(float(strike_s)) ]
# olist = [ float(strike_s) ]
# print(olist)

sys.exit(0)

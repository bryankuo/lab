#!/usr/bin/python3

# python3 commodities.py

import sys, requests, time, webbrowser
import urllib.request
from urllib.parse   import quote
from urllib.request import urlopen

from datetime import timedelta,datetime
from bs4 import BeautifulSoup

soybean = "https://www.barchart.com/futures/quotes/ZS*0/technical-chart"
us_wheat = "https://www.investing.com/commodities/us-wheat-candlestick"
corn = "https://futures.tradingcharts.com/chart/ZC/"
oats = "https://www.investing.com/commodities/oats-candlestick"

uranium = "https://tradingeconomics.com/commodity/uranium"
bitcoin = "https://candlecharts.com/candlestick-chart-look-up/btc-candlestick-chart/"

# //TODO:
daytrade = "https://stock.wearn.com/finquitsp.asp"
hinet_dt = "https://histock.tw/stock/rank.aspx?m=11&d=1&t=dt"
good_info = "https://goodinfo.tw/tw/StockList.asp?SHEET=現股當沖&MARKET_CAT=熱門排行&INDUSTRY_CAT=現股當沖率"
# one day behind
fubon = "https://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZG_EJ.djhtm"
# one day behind
tpex = "https://www.tpex.org.tw/web/stock/trading/intraday_stat/intraday_trading_stat.php?l=zh-tw"

# institutional buying and selling
fbs = "http://fubon-ebrokerdj.fbs.com.tw/z/zg/zgk.djhtm?A=D&B=0&C=5"
fund = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZGK_DD.djhtm"
retail = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZE/ZEF/ZEF.djhtm"
b8 = "https://chart.capital.com.tw/Chart/TWII/TAIEX11.aspx"

# because URIs can't contain non-ASCII characters.
# https://stackoverflow.com/a/6938893
# //TODO: search for urllib for tips
marginal_buying = "https://goodinfo.tw/tw/ShowBearishChart.asp?STOCK_ID=加權指數&CHT_CAT=DATE"

nickel = "https://www.investing.com/commodities/nickel-candlestick"

aluminum = "https://markets.businessinsider.com/commodities/aluminum-price"

iron_ore = "https://www.marketindex.com.au/iron-ore"
brent_crude = "https://tradingeconomics.com/commodity/brent-crude-oil"
cnn_greedy_fear_meter = "https://money.cnn.com/data/fear-and-greed/"

urls = [ \
    soybean, \
    us_wheat, \
    corn, \
    oats, \

    uranium, \
    brent_crude, \

    nickel, \
    aluminum, \
    iron_ore, \

    bitcoin, \

    fbs, \
    fund, \
    retail, \
    b8, \
    marginal_buying, \

    cnn_greedy_fear_meter ]

for url in urls:
    webbrowser.open(url)
    time.sleep(1)

sys.exit(0)

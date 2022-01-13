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

b8 = "https://chart.capital.com.tw/Chart/TWII/TAIEX11.aspx"
marginal_buying = "https://goodinfo.tw/tw/ShowBearishChart.asp?STOCK_ID=加權指數&CHT_CAT=DATE"

nickel_lme = "https://www.lme.com/Metals/Non-ferrous/LME-Nickel#Trading+day+summary"

aluminum = "https://markets.businessinsider.com/commodities/aluminum-price"

iron_ore = "https://www.marketindex.com.au/iron-ore"

urls = [ \
    soybean, \
    us_wheat, \
    corn, \

    uranium, \

    nickel_lme, \
    aluminum, \
    iron_ore, \

    bitcoin, \
    fbs, \
    marginal_buying, \
    b8 ]

for url in urls:
    webbrowser.open(url)
    time.sleep(1)

sys.exit(0)
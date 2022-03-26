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
palmolive_oil = "http://quote.eastmoney.com/qihuo/pm.html"
coffee = "https://www.barchart.com/futures/quotes/KC*0/interactive-chart"

uranium = "https://tradingeconomics.com/commodity/uranium"
bitcoin = "https://candlecharts.com/candlestick-chart-look-up/btc-candlestick-chart/"
gold = "https://www.tradingview.com/symbols/TVC-GOLD/"
us10y = "https://www.marketwatch.com/investing/bond/tmubmusd10y/charts?countrycode=bx"

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

copper = "https://www.investing.com/commodities/copper-candlestick"
nickel = "https://www.investing.com/commodities/nickel-candlestick"
aluminum = "https://markets.businessinsider.com/commodities/aluminum-price"
platinum = "https://www.cmegroup.com/markets/metals/precious/platinum.html"

iron_ore = "https://www.marketindex.com.au/iron-ore"
brent_crude = "https://tradingeconomics.com/commodity/brent-crude-oil"
fear_n_greed_sentiment = "https://pyinvesting.com/fear-and-greed/"
natural_gas = "https://www.tradingview.com/symbols/NYMEX-NG1%21/"
fertilizers = "https://ycharts.com/indicators/fertilizers_index_world_bank"
rubber = "https://economictimes.indiatimes.com/commoditysummary/symbol-RUBBER.cms"

nand_flash = "https://www.trendforce.com/price"
ddr = "https://www.dramexchange.com"

emerging_market = "https://stockscan.io/stocks/EEM"
# ETF price and volume https://etfdb.com/etf/IJR/#price-and-volume

worldwide_index = "https://finance.yahoo.com/world-indices/"
finviz = "https://finviz.com"
twd_forex = "https://forex.tradingcharts.com/chart/US%20Dollar_New%20Taiwan%20Dollar.html?tz=CST&chartpair=US%2520Dollar_New%2520Taiwan%2520Dollar&ctype=b&movAvg1=&movAvg2=&per=1d"
jpy_forex = "https://www.dailyfx.com/usd-jpy"
major_futures = "https://www.cnyes.com/futures/indexftr.aspx"

urls = [ \
    # regional
    fbs, \
    fund, \
    retail, \
    b8, \

    # worldwide
    finviz, \
    major_futures, \
    emerging_market, \
    worldwide_index, \
    fear_n_greed_sentiment, \

    twd_forex, \
    jpy_forex, \
    bitcoin, \
    gold, \
    us10y, \

    # commodities
    soybean, \
    us_wheat, \
    corn, \
    oats, \
    palmolive_oil, \
    coffee, \
    rubber, \

    uranium, \
    brent_crude, \
    natural_gas, \
    fertilizers, \

    copper, \
    nickel, \
    platinum, \
    aluminum, \
    iron_ore, \

    nand_flash, \
    ddr ]

i = 0
for url in urls:
    webbrowser.open(url)
    time.sleep(1)
    i += 1
    if ( i % 10 == 9 ):
        print('\a') # beep
        input("Press Enter to continue...")

sys.exit(0)

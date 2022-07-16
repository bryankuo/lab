#!/usr/bin/python3

# python3 commodities.py

import sys, requests, time, webbrowser
import urllib.request
from urllib.parse   import quote
from urllib.request import urlopen

from datetime import timedelta,datetime,date
import calendar
from bs4 import BeautifulSoup

commo = "https://tradingeconomics.com/commodities"

soybean = "https://www.barchart.com/futures/quotes/ZS*0/technical-chart"
us_wheat = "https://www.investing.com/commodities/us-wheat-candlestick"
corn = "https://futures.tradingcharts.com/chart/ZC/"
oats = "https://www.investing.com/commodities/oats-candlestick"

# palmolive_oil = "http://quote.eastmoney.com/qihuo/pm.html"
palmolive_oil = "https://www.cnyes.com/futures/html5chart/PLKCON.html"

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
fdi = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZE/ZEE/ZEE.djhtm"
fbs = "http://fubon-ebrokerdj.fbs.com.tw/z/zg/zgk.djhtm?A=D&B=0&C=1"

fund_d = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZE/ZES/ZES.djhtm"
fund = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZGK_DD.djhtm"

retail = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZGK_DB.djhtm"
re_detail = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZE/ZEF/ZEF.djhtm"

b8 = "https://chart.capital.com.tw/Chart/TWII/TAIEX11.aspx"
government_bs = "https://www.wantgoo.com/stock/public-bank/buy-sell"
gb8_trend = "https://www.wantgoo.com/stock/public-bank/trend"

individual = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZGK_F.djhtm"

margin_b = "https://tw.stock.yahoo.com/margin-balance"

brokage_v = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZGB/ZGB.djhtm"

# because URIs can't contain non-ASCII characters.
# https://stackoverflow.com/a/6938893

copper = "https://www.investing.com/commodities/copper-candlestick"
nickel = "https://www.investing.com/commodities/nickel-candlestick"
aluminum = "https://markets.businessinsider.com/commodities/aluminum-price"
platinum = "https://www.cmegroup.com/markets/metals/precious/platinum.html"

iron_ore = "https://www.marketindex.com.au/iron-ore"
brent_crude = "https://tradingeconomics.com/commodity/brent-crude-oil"
natural_gas = "https://www.tradingview.com/symbols/NYMEX-NG1%21/"
fertilizers = "https://ycharts.com/indicators/fertilizers_index_world_bank"
rubber = "https://economictimes.indiatimes.com/commoditysummary/symbol-RUBBER.cms"

nand_flash = "https://www.trendforce.com/price"
ddr = "https://www.dramexchange.com"

emerging_market = "https://stockscan.io/stocks/EEM"
# ETF price and volume https://etfdb.com/etf/IJR/#price-and-volume

worldwide_index = "https://finance.yahoo.com/world-indices/"
aaii_sentiment = "https://ycharts.com/indicators/reports/aaii_sentiment_survey"
fear_n_greed_sentiment = "https://pyinvesting.com/fear-and-greed/"
cnn_gfear = "https://edition.cnn.com/markets/fear-and-greed"

finviz = "https://finviz.com"
twd_forex = "https://forex.tradingcharts.com/chart/US%20Dollar_New%20Taiwan%20Dollar.html?tz=CST&chartpair=US%2520Dollar_New%2520Taiwan%2520Dollar&ctype=b&movAvg1=&movAvg2=&per=1d"
jpy_forex = "https://www.dailyfx.com/usd-jpy"
dailyfx = "https://www.dailyfx.com/forex-rates#currencies"

major_futures = "https://www.cnyes.com/futures/indexftr.aspx"

glass = "https://quote.eastmoney.com/qihuo/FGM.html"

jlp_watchlist = "https://jlprudentmenu.blogspot.com"

twse_calendar = "https://histock.tw/stock/stockskd.aspx"

yuanta_calendar = "https://www.yuanta.com.tw/eYuanta/securities/Node/Index?MainId=00413&C1=2018031202503224&ID=2018031202503224&Level=1&rnd=25104"


fl_calendar = "https://ww2.money-link.com.tw/TWStock/TWStockMarket.aspx?optionType=6"

gtrend = "https://trends.google.com/trends/explore?geo=TW"

doji = "http://localhost"

urls = [ \
    # regional
    margin_b, \
    # fdi, \
    fbs, \
    # fund_d, \
    fund, \
    # re_detail, \
    retail, \
    individual, \
    # b8, \
    government_bs, \
    gb8_trend, \
    brokage_v, \
    # jlp_watchlist, \

    # commodities
    commo, \
    # soybean, \
    # us_wheat, \
    # corn, \
    # oats, \
    # palmolive_oil, \
    # coffee, \
    # rubber, \
    # uranium, \
    # brent_crude, \
    natural_gas, \
    fertilizers, \
    glass, \
    copper, \
    nickel, \
    platinum, \
    aluminum, \
    iron_ore, \
    nand_flash, \
    ddr, \

    # worldwide
    finviz, \
    major_futures, \
    emerging_market, \
    worldwide_index, \
    fear_n_greed_sentiment, \
    cnn_gfear, \
    aaii_sentiment, \

    twd_forex, \
    jpy_forex, \
    dailyfx, \
    bitcoin, \
    gold, \
    us10y, \
    jlp_watchlist, \
    twse_calendar, \
    yuanta_calendar, \
    fl_calendar, \
    gtrend, \
    doji ]

curr_date = date.today()
msg = "it is " + str(datetime.today().isoweekday()) + \
    " " + calendar.day_name[curr_date.weekday()]
print(msg)
# // TODO: on demand, daily, weekly, monthly bases
i = 0
for url in urls:
    webbrowser.open(url)
    time.sleep(1)
    i += 1
    if ( i % 10 == 9 ):
        print('\a') # beep
        input("Press Enter to continue...")

sys.exit(0)

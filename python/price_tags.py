#!/usr/bin/python3

# python3 commodities.py

import sys, requests, time, webbrowser
import urllib.request
from urllib.parse   import quote
from urllib.request import urlopen

from datetime import datetime, date, time, timedelta
from dateutil.relativedelta import relativedelta

import calendar
from bs4 import BeautifulSoup

commo = "https://tradingeconomics.com/commodities"
copper = "https://www.investing.com/commodities/copper-candlestick"
crb_idx = "https://www.barchart.com/futures/quotes/BZY00/interactive-chart"
brent_crude = "https://tradingeconomics.com/commodity/brent-crude-oil"
# a leading index
btcusd = "https://www.tradingview.com/chart/?symbol=BITSTAMP%3ABTCUSD"
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

margin_b  = "https://tw.stock.yahoo.com/margin-balance"
vol_ratio = "https://tw.stock.yahoo.com/trading-vol-ratio"

brokage_v = "http://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZGB/ZGB.djhtm"

twse_pledge = "上市櫃公司董監質設異動公告"
twse_heatmap = "https://www.nstock.tw/market_index/heatmap?t1=0&t2=0&t3=0&t4=1&t5=0&iid&nh=0"

commo = "https://tradingeconomics.com/commodities"

fertilizers = "https://ycharts.com/indicators/fertilizers_index_world_bank"
potash_f = "https://ca.investing.com/etfs/global-x-fertilizers-potash-candlestick#"
soybean = "https://www.barchart.com/futures/quotes/ZS*0/technical-chart"

us_wheat = "https://www.investing.com/commodities/us-wheat-candlestick"
corn = "https://futures.tradingcharts.com/chart/ZC/"
oats = "https://www.investing.com/commodities/oats-candlestick"
# palmolive_oil = "http://quote.eastmoney.com/qihuo/pm.html"
palmolive_oil = "https://www.cnyes.com/futures/html5chart/PLKCON.html"
coffee = "https://www.barchart.com/futures/quotes/KC*0/interactive-chart"

uranium = "https://tradingeconomics.com/commodity/uranium"
copper = "https://www.investing.com/commodities/copper-candlestick"
nickel = "https://www.investing.com/commodities/nickel-candlestick"
aluminum = "https://markets.businessinsider.com/commodities/aluminum-price"
platinum = "https://www.cmegroup.com/markets/metals/precious/platinum.html"
iron_ore = "https://www.marketindex.com.au/iron-ore"
gold = "https://candlecharts.com/candlestick-chart-look-up/gold-candlestick-chart/"
brent_crude = "https://tradingeconomics.com/commodity/brent-crude-oil"
natural_gas = "https://www.tradingview.com/symbols/NYMEX-NG1%21/"
# rubber = "https://www.indexmundi.com/commodities/?commodity=rubber&months=12"
rubber = "https://tradingeconomics.com/commodity/rubber#"
commodities = [ \
    natural_gas, \
    rubber, \
]

nand_flash = "https://www.trendforce.com/price"
ddr = "https://www.dramexchange.com"
glass = "https://quote.eastmoney.com/qihuo/FGM.html"
paper = "https://www.moneydj.com/z/ze/zeq/zeqa_d0190020.djhtm"

doji = "http://localhost"

# because URIs can't contain non-ASCII characters.
# https://stackoverflow.com/a/6938893

curr_date = date.today()
if datetime.today().isoweekday() == 6:
    effective_date = date.today() + relativedelta(days=-1)
elif datetime.today().isoweekday() == 7:
    effective_date = date.today() + relativedelta(days=-2)
elif datetime.today().isoweekday() == 1:
    effective_date = date.today() + relativedelta(days=-3)
else:
    effective_date = date.today()
yyyymmdd   = date.today().strftime('%Y%m%d')
yyyymmdd_e = effective_date.strftime('%Y%m%d')
msg = "it is (" + str(datetime.today().isoweekday()) + ") " + \
    calendar.day_name[curr_date.weekday()] + " " + \
    yyyymmdd + " effective " + yyyymmdd_e
print(msg)

tw_start = time(9, 30)
tw_end   = time(13, 30)
current = time( datetime.now().hour, datetime.now().minute )
if datetime.today().isoweekday() in ( 1, 2, 3, 4, 5 ):
    if tw_start <= current <= tw_end :
        print('tw market is opened')
        webbrowser.open(fl_calendar)
    else:
        print('tw market is closed')
else:
    print('tw market is closed')
# sys.exit(0)

# daily bases
block_pair_trade = "https://www.twse.com.tw/block/BFIAUU" + \
    "?response=html&date="+yyyymmdd_e+"&selectType=S"

# 申報轉讓明細, update on daily bases
insider_trade = "http://jsjustweb.jihsun.com.tw/z/ze/zei/zei.djhtm"
# "https://www.esunsec.com.tw/tw-market/z/ze/zei/zei.djhtm"
# "https://www.moneydj.com/Z/ZE/ZEI/ZEI.djhtm"
# how to link to https://mops.twse.com.tw/mops/web/t93sb06 ?
# 一般交易: distribution
# 贈與: tax cut
# daily bases

emerging_market = "https://stockscan.io/stocks/EEM"
# ETF price and volume https://etfdb.com/etf/IJR/#price-and-volume

worldwide_index = "https://finance.yahoo.com/world-indices/"
nikkei = "https://indexes.nikkei.co.jp/en/nkave/index/profile?idx=nk225"
nikkei_futures = "https://www.investing.com/indices/japan-225-futures"
aaii_sentiment = "https://ycharts.com/indicators/reports/aaii_sentiment_survey"
fear_n_greed_sentiment = "https://pyinvesting.com/fear-and-greed/"
cnn_gfear = "https://edition.cnn.com/markets/fear-and-greed"

finviz = "https://finviz.com"
twd_forex = "https://forex.tradingcharts.com/chart/US%20Dollar_New%20Taiwan%20Dollar.html?tz=CST&chartpair=US%2520Dollar_New%2520Taiwan%2520Dollar&ctype=b&movAvg1=&movAvg2=&per=1d"
jpy_forex = "https://www.dailyfx.com/usd-jpy"
dailyfx = "https://www.dailyfx.com/forex-rates#currencies"
mmicro = "https://www.macromicro.me/forex?utm_campaign=&utm_content=post&utm_medium=social&utm_source=groups"

major_futures = "https://www.cnyes.com/futures/indexftr.aspx"

jlp_watchlist = "https://jlprudentmenu.blogspot.com"
twse_calendar = "https://histock.tw/stock/stockskd.aspx"
yuanta_calendar = "https://www.yuanta.com.tw/eYuanta/securities/Node/Index?MainId=00413&C1=2018031202503224&ID=2018031202503224&Level=1&rnd=25104"
fl_calendar = "https://ww2.money-link.com.tw/TWStock/TWStockMarket.aspx?optionType=6"
short_cover_calendar = "https://goodinfo.tw/tw/MarginPauseScheduleList.asp?MARKET_CAT=全部&INDUSTRY_CAT=全部&YEAR=即將發生"

# gtrend = "https://trends.google.com/trends/explore?geo=TW"
gtrend = "https://trends.google.com/trends/explore?date=today%201-m&geo=TW"

nyse_tick_idx = "https://www.investing.com/indices/nyse-tick-index-chart"
sdog = "https://statementdog.com/market-trend?utm_source=user_mailer&utm_medium=email&utm_campaign=send_market_spotlight_earnings_calls"
trans_idx = "https://www.spglobal.com/spdji/en/indices/equity/dow-jones-transportation-average/#overview"

tsm = "https://www.investing.com/equities/taiwan-semicond.manufacturing-co-candlestick"

google_pledge = "https://www.google.com/search?q=" + \
    "quote(董監質設異動公告)+" \
    "&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:"  + \
    "1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWC" + \
    "JaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"

fiscal_calendar = "https://markets.businessinsider.com/earnings-calendar"

weekly_bases = [ \
    gtrend, \
    twse_calendar, \
    # yuanta_calendar, \
    fl_calendar, \
    jlp_watchlist, \

    copper,   \
    gold,     \
    nickel,   \
    aluminum, \
    platinum, \
    uranium,  \
    iron_ore, \

    brent_crude, \
    natural_gas, \
    rubber,      \
    glass,       \
    paper,       \

    nand_flash,  \
    ddr,         \

    fertilizers, \
    potash_f, \
    soybean,  \

    oats,     \
    us_wheat, \
    corn,     \
    palmolive_oil, \
    coffee
]

daily_bases = [ \
    # regional
    margin_b,         \
    vol_ratio,        \
    block_pair_trade, \
    insider_trade,    \

    # use qfbs.sh instead
    # fbs,              \
    # fund,             \
    # retail,           \
    # individual,       \
    # government_bs,    \
    # gb8_trend,        \
    # brokage_v,        \
    tsm,              \

    # commodities @see candlestick.py
    crb_idx, \
    # commo, \
    copper, \
    brent_crude, \
    btcusd, \

    # worldwide
    # finviz, \
    major_futures, \
    emerging_market, \

    twd_forex, \
    jpy_forex, \
    dailyfx, \

    worldwide_index, \
    fear_n_greed_sentiment, \
    cnn_gfear, \
    aaii_sentiment,
    nyse_tick_idx, \
    sdog, \
    trans_idx, \
    fiscal_calendar, \
    short_cover_calendar, \
    twse_heatmap, \

    mmicro, \
    us10y, \
    doji ]

# hourly based

# // TODO: on demand, daily, weekly, monthly bases

i = 0
for url in daily_bases:
    webbrowser.open(url)
    i += 1
    if ( i % 3 == 2 ):
        print('\a') # beep
        input("Press Enter to continue...")

# daily
# // TODO: announcement_today.py
# // TODO: calendars

# weekly bases, saturday, sunday
if datetime.today().isoweekday() in ( 6, 7 ):
    i = 0
    for url in weekly_bases:
        webbrowser.open(url)
        i += 1
        if ( i % 3 == 2 ):
            print('\a') # beep
            input("Press Enter to continue...")

sys.exit(0)

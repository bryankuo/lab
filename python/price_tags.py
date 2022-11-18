#!/usr/bin/python3

# python3 commodities.py

import sys, requests, time, webbrowser
import urllib.request
from urllib.parse   import quote
from urllib.request import urlopen

from datetime import datetime, date, time, timedelta

import calendar
from bs4 import BeautifulSoup

commo = "https://tradingeconomics.com/commodities"
crb_idx = "https://www.barchart.com/futures/quotes/BZY00/interactive-chart"

bitcoin = "https://candlecharts.com/candlestick-chart-look-up/btc-candlestick-chart/"
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

twse_pledge = "上市櫃公司董監質設異動公告"

# because URIs can't contain non-ASCII characters.
# https://stackoverflow.com/a/6938893

insider_1m = "http://jsjustweb.jihsun.com.tw/z/ze/zei/zei.djhtm"
# "https://www.esunsec.com.tw/tw-market/z/ze/zei/zei.djhtm"
# "https://www.moneydj.com/Z/ZE/ZEI/ZEI.djhtm"

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
mmicro = "https://www.macromicro.me/forex?utm_campaign=&utm_content=post&utm_medium=social&utm_source=groups"

major_futures = "https://www.cnyes.com/futures/indexftr.aspx"

jlp_watchlist = "https://jlprudentmenu.blogspot.com"
twse_calendar = "https://histock.tw/stock/stockskd.aspx"
yuanta_calendar = "https://www.yuanta.com.tw/eYuanta/securities/Node/Index?MainId=00413&C1=2018031202503224&ID=2018031202503224&Level=1&rnd=25104"
fl_calendar = "https://ww2.money-link.com.tw/TWStock/TWStockMarket.aspx?optionType=6"

# gtrend = "https://trends.google.com/trends/explore?geo=TW"
gtrend = "https://trends.google.com/trends/explore?date=today%201-m&geo=TW"

nyse_tick_idx = "https://www.investing.com/indices/nyse-tick-index-chart"
sdog = "https://statementdog.com/market-trend?utm_source=user_mailer&utm_medium=email&utm_campaign=send_market_spotlight_earnings_calls"
trans_idx = "https://www.spglobal.com/spdji/en/indices/equity/dow-jones-transportation-average/#overview"

curr_date = date.today()
yyyymmdd = datetime.today().strftime('%Y%m%d')
msg = "it is " + str(datetime.today().isoweekday()) + \
    " " + calendar.day_name[curr_date.weekday()] + \
    " " + yyyymmdd
print(msg)

block_pair_trade = "https://www.twse.com.tw/block/BFIAUU" + \
    "?response=html&date="+yyyymmdd+"&selectType=S"

google_pledge = "https://www.google.com/search?q=" + \
    "quote(董監質設異動公告)+" \
    "&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:"  + \
    "1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWC" + \
    "JaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"

weekly_bases = [ \
    gtrend, \
    twse_calendar, \
    # yuanta_calendar, \
    # fl_calendar, \
    jlp_watchlist, \
    # insider_1m \
]

doji = "http://localhost"

urls = [ \
    # regional
    margin_b, \
    block_pair_trade, \
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

    # commodities
    crb_idx, \
    commo, \

    # worldwide
    finviz, \
    major_futures, \
    emerging_market, \
    worldwide_index, \
    fear_n_greed_sentiment, \
    cnn_gfear, \
    aaii_sentiment,
    nyse_tick_idx, \
    sdog, \
    trans_idx, \

    twd_forex, \
    jpy_forex, \
    dailyfx, \
    mmicro, \
    bitcoin, \
    us10y, \
    doji ]



# hourly based
tw_start = time(9, 30)
tw_end   = time(13, 30)
current = time( datetime.now().hour, datetime.now().minute )
if tw_start <= current <= tw_end :
    print('tw market is opened')
    webbrowser.open(fl_calendar)
    webbrowser.open(insider_1m)
else:
    print('tw market is closed')

# // TODO: on demand, daily, weekly, monthly bases

# weekly bases
# monday
print( datetime.today().isoweekday() )
if datetime.today().isoweekday() in range(1, 6):

    for url in weekly_bases:
        webbrowser.open(url)
        print('\a') # beep
    input("Press Enter to continue...")

    i = 0
    for url in urls:
        webbrowser.open(url)
        # datetime.time.sleep(1) // FIXME:
        i += 1
        if ( i % 10 == 9 ):
            print('\a') # beep
            input("Press Enter to continue...")
# daily

sys.exit(0)

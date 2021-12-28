#!/usr/bin/python3

# python3 web_search.py 2330
# return 0: success

import sys, requests, time, webbrowser
from urllib.parse   import quote
from urllib.request import urlopen

ticker = sys.argv[1]

ticker_news = \
    "http://jsjustweb.jihsun.com.tw/Z/ZC/ZCV/ZCV_" + ticker + ".djhtm"

fundamental = \
    "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca.djhtm?a=" + ticker

# google news search
# unicode encoding ( https://bit.ly/3syqeyC )
google_news = "https://www.google.com/search?q="+ticker+"+"+quote("新聞")+"&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWCJaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"

subsidiary = "https://www.cmoney.tw/finance/f00031.aspx?s="+ticker

revenue_mom = \
    "https://goodinfo.tw/StockInfo/ShowSaleMonChart.asp?STOCK_ID="+ticker

groups = "https://thaubing.gcaa.org.tw/group/name/G"+ticker

volume_profile = \
    "https://www.esunsec.com.tw/tw-stock/z/zc/zcw/zcwg/zcwg.djhtm?id=" \
    + ticker

tech_chart = "https://invest.cnyes.com/twstock/TWS/" + ticker + "/technical"

institution_holdings = "https://www.wantgoo.com/stock/" + ticker \
    + "/institutional-investors/trend"

hinet_technicals = "https://histock.tw/stock/"+ticker

cmoney_gossip = "https://www.cmoney.tw/follow/channel/stock-" + \
    ticker +"?chart=d&type=Personal"

share_outstanding = \
    "https://norway.twsthr.info/StockHolders.aspx?stock="+ticker

management = ""
urls = [ \
    fundamental, \
    revenue_mom, \
    groups, \
    subsidiary, \
    ticker_news, \
    volume_profile, \
    google_news, \
    tech_chart, \
    institution_holdings, \
    hinet_technicals, \
    cmoney_gossip, \
    share_outstanding, \
    management ]

for url in urls:
    webbrowser.open(url)
    time.sleep(1)

sys.exit(0)

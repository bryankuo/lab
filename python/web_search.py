#!/usr/bin/python3

# python3 web_search.py 2330
# return 0: success

import sys, requests, time, webbrowser

ticker = sys.argv[1]

ticker_news = \
    "http://jsjustweb.jihsun.com.tw/Z/ZC/ZCV/ZCV_" + ticker + ".djhtm"

fundamental = \
    "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca.djhtm?a=" + ticker

# google news search
google_news = "https://www.google.com/search?q="+ticker+"+新聞&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWCJaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"

subsidiary = "https://www.cmoney.tw/finance/f00031.aspx?s="+ticker

revenue_mom = \
    "https://goodinfo.tw/StockInfo/ShowSaleMonChart.asp?STOCK_ID="+ticker

groups = "https://thaubing.gcaa.org.tw/group/name/G"+ticker

management = ""
urls = [ \
    fundamental, \
    revenue_mom, \
    groups, \
    subsidiary, \
    ticker_news, \
    google_news, \
    management ]

for url in urls:
    webbrowser.open(url)
    time.sleep(1)

sys.exit(0)

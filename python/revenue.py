#!/usr/bin/python3

# python3 revenue.py 2330
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "https://goodinfo.tw/StockInfo/ShowSaleMonChart.asp?STOCK_ID="+ticker
webbrowser.open(url)
sys.exit(0)

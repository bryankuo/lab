#!/usr/bin/python3

# python3 branch.py 2330
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "https://histock.tw/stock/branch.aspx?no="+ticker
webbrowser.open(url)
# date is available
# https://histock.tw/stock/branch.aspx?no=1514&from=20210713&to=20210713
sys.exit(0)

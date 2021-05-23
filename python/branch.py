#!/usr/bin/python3

# python3 branch.py 2330
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "https://histock.tw/stock/branch.aspx?no="+ticker
webbrowser.open(url)
sys.exit(0)

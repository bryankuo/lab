#!/usr/bin/python3

# python3 reinvestments.py 2330
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "https://www.cmoney.tw/finance/f00031.aspx?s="+ticker
webbrowser.open(url)
sys.exit(0)

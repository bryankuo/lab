#!/usr/bin/python3

# python3 technical.py 2330
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "https://histock.tw/stock/"+ticker
webbrowser.open(url)
sys.exit(0)

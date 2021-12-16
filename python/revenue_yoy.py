#!/usr/bin/python3

# python3 revenue_yoy.py ticker
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zch/zch_" + ticker + ".djhtm"
webbrowser.open(url)
sys.exit(0)

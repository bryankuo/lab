#!/usr/bin/python3

# python3 profile.py 2330
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "https://www.google.com/search?client=safari" + \
    "&rls=en&q=moneydj+財經百科+"+ticker+"&ie=UTF-8&oe=UTF-8"

webbrowser.open(url)
sys.exit(0)

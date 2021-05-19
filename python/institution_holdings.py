#!/usr/bin/python3

# python3 instituion_holdings.py 2330
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "https://www.wantgoo.com/stock/" + ticker \
    + "/institutional-investors/trend"
webbrowser.open(url)
sys.exit(0)

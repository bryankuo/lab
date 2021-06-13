#!/usr/bin/python3

# python3 profile.py 2330
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "https://www.google.com/search?q="+ticker+"+ptt+stock&client=safari&sxsrf=ALeKk02tz2-BrxlgznV37pUb3jBhfWDw8A:1623571437756&source=lnt&tbs=qdr:y&sa=X&ved=2ahUKEwi1i8L2kpTxAhWrzIsBHeciAhQQpwV6BAgBECQ&biw=1440&bih=709"
webbrowser.open(url)
sys.exit(0)

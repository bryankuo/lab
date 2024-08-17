#!/usr/bin/python3

# python3 commodities.py
# @see price_tags.py

import sys, webbrowser

us10y = "https://www.marketwatch.com/investing/bond/tmubmusd10y/charts?countrycode=bx"
c2gr = "https://en.macromicro.me/charts/15943/copper-gold-ratio"
brent_crude = "https://tradingeconomics.com/commodity/brent-crude-oil"
btcusd = "https://www.tradingview.com/chart/?symbol=BITSTAMP%3ABTCUSD"
gold = "https://candlecharts.com/candlestick-chart-look-up/gold-candlestick-chart/"
cnn_gfear = "https://edition.cnn.com/markets/fear-and-greed"
# gheatmap = "https://finviz.com/map.ashx?t=geo"
vixtwn = "https://www.wantgoo.com/index/vixtwn"
sox = "https://www.investing.com/indices/phlx-semiconductor-candlestick#"
twd_forex = \
"https://forex.tradingcharts.com/chart/US%20Dollar_New%20Taiwan%20Dollar.html?tz=CST&chartpair=US%2520Dollar_New%2520Taiwan%2520Dollar&ctype=b&movAvg1=&movAvg2=&per=w"

my10idx_list = [
    us10y, c2gr, brent_crude, btcusd, gold, cnn_gfear, gheatmap, sox, twd_forex
]

for url in my10idx_list:
    webbrowser.open(url)
    # input("Press Enter to continue...")
    # print('\a') # beep works

sys.exit(0)

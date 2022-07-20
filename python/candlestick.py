#!/usr/bin/python3

# python3 commodities.py

import sys, requests, time, webbrowser
import urllib.request
from urllib.parse   import quote
from urllib.request import urlopen

from datetime import timedelta,datetime,date
import calendar
from bs4 import BeautifulSoup

commo = "https://tradingeconomics.com/commodities"

soybean = "https://www.barchart.com/futures/quotes/ZS*0/technical-chart"
us_wheat = "https://www.investing.com/commodities/us-wheat-candlestick"
corn = "https://futures.tradingcharts.com/chart/ZC/"
oats = "https://www.investing.com/commodities/oats-candlestick"
# palmolive_oil = "http://quote.eastmoney.com/qihuo/pm.html"
palmolive_oil = "https://www.cnyes.com/futures/html5chart/PLKCON.html"
coffee = "https://www.barchart.com/futures/quotes/KC*0/interactive-chart"

uranium = "https://tradingeconomics.com/commodity/uranium"
copper = "https://www.investing.com/commodities/copper-candlestick"
nickel = "https://www.investing.com/commodities/nickel-candlestick"
aluminum = "https://markets.businessinsider.com/commodities/aluminum-price"
platinum = "https://www.cmegroup.com/markets/metals/precious/platinum.html"
iron_ore = "https://www.marketindex.com.au/iron-ore"
gold = "https://www.tradingview.com/symbols/TVC-GOLD/"
metals = [ \
    gold, copper, nickel, aluminum, platinum, iron_ore ]

brent_crude = "https://tradingeconomics.com/commodity/brent-crude-oil"
fertilizers = "https://ycharts.com/indicators/fertilizers_index_world_bank"
natural_gas = "https://www.tradingview.com/symbols/NYMEX-NG1%21/"
# rubber = "https://www.indexmundi.com/commodities/?commodity=rubber&months=12"
rubber = "https://tradingeconomics.com/commodity/rubber#"
commodities = [ \
    natural_gas, \
    rubber, \
]

nand_flash = "https://www.trendforce.com/price"
ddr = "https://www.dramexchange.com"
glass = "https://quote.eastmoney.com/qihuo/FGM.html"
paper = "https://www.moneydj.com/z/ze/zeq/zeqa_d0190020.djhtm"

bitcoin = "https://candlecharts.com/candlestick-chart-look-up/btc-candlestick-chart/"

doji = "http://localhost"

urls = [ \
    oats,     \
    soybean,  \
    us_wheat, \
    corn,     \
    palmolive_oil, \
    coffee,   \

    copper,   \
    gold,     \
    nickel,   \
    aluminum, \
    platinum, \
    uranium,  \
    iron_ore, \

    brent_crude, \
    fertilizers, \
    natural_gas, \
    rubber,      \
    glass,       \
    paper,       \

    nand_flash,  \
    ddr,         \

    bitcoin \
]

ticker = sys.argv[1]

if ticker == "oats" :
    thing = oats

elif ticker == "copper" :
    thing = copper

elif ticker == "bitcoin" :
    thing = bitcoin

elif ticker == "rubber" :
    thing = rubber

elif ticker == "metal" :
    i = 0
    for url in metals:
        webbrowser.open(url)
        time.sleep(1)
        i += 1
        if ( i % 10 == 9 ):
            print('\a') # beep
            input("Press Enter to continue...")
    sys.exit(0)

elif ticker == "commodities" :
    i = 0
    for url in commodities:
        webbrowser.open(url)
        time.sleep(1)
        i += 1
        if ( i % 10 == 9 ):
            print('\a') # beep
            input("Press Enter to continue...")
    sys.exit(0)

elif ticker == "all" :
    i = 0
    for url in urls:
        webbrowser.open(url)
        time.sleep(1)
        i += 1
        if ( i % 10 == 9 ):
            print('\a') # beep
            input("Press Enter to continue...")
    sys.exit(0)

else:
    thing = doji

webbrowser.open(thing)
print('\a') # beep

sys.exit(0)

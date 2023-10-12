#!/usr/bin/python3

# python3 get_mrkt_value.py [yyyymmdd]
# source 1, top 100, update on daily basis
# https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm?MSCI=0
# return 0
# 1:2330台積電:17,425,215:30.87%

import sys, requests, time, re, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException

if ( len(sys.argv) < 2 ):
    print("usage: get_mrkt_value [yyyymmdd]")
    sys.exit(0)

DIR0="./datafiles/taiex" # consider compatible with rank.sh
fname = "top100_market_value."+sys.argv[1]+".html"
path = os.path.join(DIR0, fname)

outf0_name = "top100_market_value."+sys.argv[1]+".txt"
path_outf0 = os.path.join(DIR0, outf0_name)

bounty_name = "bountylist.top100_market_value."+sys.argv[1]+".txt"
path_bounty = os.path.join(DIR0, bounty_name)

try:
    url = "https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm?MSCI=0"
    response = requests.get(url)
    response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')

    with open(path, "w") as outfile:
        outfile.write(soup.prettify())
    outfile.close()

    rows = soup.find_all("table", {})[2] \
            .find_all("tr")

    with open(path_outf0, "w") as outfile, \
        open(path_bounty, "w") as outfile1:
        outfile.write( "排行:代號公司:總市值(M):權重\n" )
        index = 1
        for i in range(3, len(rows)):
            rank      = str(index)
            tkr_name  = rows[i].find_all('td')[0].text.strip()
            mkt_value = rows[i].find_all('td')[1].text
            weight = rows[i].find_all('td')[2].text

            outfile.write( rank + ":" + \
                tkr_name + ":" + \
                mkt_value + ":" + \
                weight + '\n' )

            outfile1.write( tkr_name[0:4] + '\n' )
            index += 1
except:
    traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    outfile.close()
    outfile1.close()

sys.exit(0)

#!/usr/bin/python3

# python3 get_mrkt_value.py
# source 1, top 100, update on daily basis
# https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm?MSCI=0
# return 0
# 1:2330台積電:17,425,215:30.87%

import sys, requests, time, re
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException

try:
    url = "https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm?MSCI=0"
    response = requests.get(url)
    response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    rows = soup.find_all("table", {})[2] \
            .find_all("tr")
    print( "排行:代號公司:總市值(M):權重" )
    index = 1
    for i in range(3, len(rows)):
        rank      = str(index)
        tkr_name  = rows[i].find_all('td')[0].text.strip()
        mkt_value = rows[i].find_all('td')[1].text
        weight = rows[i].find_all('td')[2].text
        print( \
            rank + ":" + \
            tkr_name + ":" + \
            mkt_value + ":" + \
            weight )
        index += 1

finally:
    sys.exit(0)

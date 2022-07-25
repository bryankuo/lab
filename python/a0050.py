#!/usr/bin/python3

# python3 a0050.py
# get TAIEX 50 components
# return 0: success

import sys, requests, time
import urllib.request, json, re
# import json5
from pprint import pprint
from bs4 import BeautifulSoup
# from selenium import webdriver
# from selenium.webdriver import Safari
from selenium import webdriver
# 1.install selenium ( https://bit.ly/3xX2tzw )
# 2.configure must enable the ‘Allow Remote Automation’ everytime
#   ( https://bit.ly/3dcZawg )
# from selenium.webdriver.support.wait import WebDriverWait
# from selenium.webdriver.common.by import By
# from selenium.webdriver.support import expected_conditions as EC
from slimit import ast
from slimit.parser import Parser
from slimit.visitors import nodevisitor

browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
if ( browser is None ):
    print("make sure safari automation enabled")
    sys.exit(3)

# source 1 a0050.txt, rank, name weight, shares*
# url = 'https://www.yuantaetfs.com/product/detail/0050/ratio'

# source 2 key0050.txt, weight rank, name only
# url = 'https://www.cmoney.tw/etf/e210.aspx?key=0050'

# source 3, update monthly, weight rank only, official*
# https://www.taifex.com.tw/cht/2/weightedPropertion

# source 4, from 1 to 300*, selenium
# https://goodinfo.tw/tw/StockList.asp?SHEET=公司基本資料&MARKET_CAT=熱門排行&INDUSTRY_CAT=公司總市值

# source 5, top 30
# https://www.cnyes.com/twstock/ranking9.aspx

# source 6, weight top 100, update on daily basis
# https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm

# source 7, tpex only, full list, update everyday
# https://www.tpex.org.tw/web/stock/aftertrading/daily_mktval/mkt_result.php?l=zh-tw&d=111/01/14&s=0,asc,0&o=htm

# source 8, 5 pages, top 150, update everyday, market value, rank
url = 'https://pchome.megatime.com.tw/rank/sto2/ock31_5.html'

# //TODO: check if get_market_capital.py is redundant.
# //TODO: check if get_mrkt_value.py.histock redundant.

browser.get(url)
time.sleep(5) # wait until page fully loaded

# stockweights
page = browser.page_source
soup = BeautifulSoup(page, 'html.parser')
browser.close()
# print(soup.prettify())

'''
component_list = "datafiles/t50.components.20211016"
with open(component_list) as fp:
    soup = BeautifulSoup(fp, 'html.parser')
table = soup.find_all("table", {"class": "tb tb1"})
pprint(table)
'''
# 'selenium.common.exceptions.SessionNotCreatedException'
sys.exit(0)

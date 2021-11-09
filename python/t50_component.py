#!/usr/bin/python3

# python3 t50_component.py
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

'''
browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
if ( browser is None ):
    print("make sure safari automation enabled")
    sys.exit(3)
# url = 'https://www.yuantaetfs.com/#/FundWeights/1066'
# url = 'https://www.yuantaetfs.com/product/detail/0050/ratio'
url = 'https://www.cmoney.tw/etf/e210.aspx?key=0050'
browser.get(url)
time.sleep(5) # wait until page fully loaded

# stockweights
page = browser.page_source
soup = BeautifulSoup(page, 'html.parser')
browser.quit()
# print(soup.prettify())
'''

# component_list = "datafiles/t50.txt.20211109"
component_list = "datafiles/t50.components.20211016"
with open(component_list) as fp:
    soup = BeautifulSoup(fp, 'html.parser')
'''
scripts = soup.find_all("script", {})
# pprint(scripts[8]); print(len(scripts))
pattern = re.compile(r"window.__NUXT__=((.*?)\{.*?\}(.*?));")
script = soup.find("script", text=pattern)
pattern1 = re.compile(r"StockWeights:\[.*?\]")
w = re.search(pattern1, str(script)).group(0)
# print(type(w))
# print(len(w))
# print(w[14:len(w)-1])
sw = w[14:len(w)-1].split(',{')
# print(len(sw))
# pprint(sw)
for weight in sw:
    print(weight)
    # pattern2 = re.compile(r"weights:(.*?)")
    # print(re.search(pattern2, weight))
'''
table = soup.find_all("table", {"class": "tb tb1"})
pprint(table)



sys.exit(3)
table = soup.find_all("table", {"id": "stockweights"})
if ( table is None ):
    sys.exit(1)
rows = table[0].select('tr')
if ( len(rows) <= 0 ):
    sys.exit(2)
for row in rows:
    tds = row.select('td')
    if ( 0 < len(tds) ):
        tkr_name = tds[0].text.strip() + tds[1].text.strip()
        weight = tds[2].text.strip()
        shares = tds[3].text.strip()
    print( \
        tkr_name, ":", \
        weight, ":", \
        shares )

sys.exit(0)

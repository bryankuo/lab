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

new_table=[]

'''
browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
if ( browser is None ):
    print("make sure safari automation enabled")
    sys.exit(3)
# url = 'https://www.yuantaetfs.com/product/detail/0050/ratio'
url = 'https://www.cmoney.tw/etf/e210.aspx?key=0050'
browser.get(url)
time.sleep(5) # wait until page fully loaded

# stockweights
page = browser.page_source
soup = BeautifulSoup(page, 'html.parser')
browser.close()
# print(soup.prettify())
'''

component_list = "a.txt"
with open(component_list) as fp:
    soup = BeautifulSoup(fp, 'html.parser')

table = soup.find_all("table", {"class": "tb tb1"})
# pprint(table)
rows = soup.find_all("tr", {})

# ths=soup.find_all("tr", {})[0].find_all("th")
# row=[]
# row.append( ths[0].text + ths[1].text )
# row.append( ths[3].text )
# new_table.append(row)

for i in range(1, len(rows)):
    tds=soup.find_all("tr", {})[i].find_all("td")
    if ( len(tds[0].text) == 4 ):
        row=[]
        row.append( tds[0].text + tds[1].text )
        row.append( tds[3].text )
        new_table.append(row)
# pprint(new_table)

for row in new_table:
    tkr_name = row[0]
    weight   = row[1]
    print( tkr_name + ":" + weight )

sys.exit(0)

#!/usr/bin/python3

# python3 t50_component.py
# get TAIEX 50 components
# return 0: success

import sys, requests, time
import urllib.request, json
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

browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
if ( browser is None ):
    print("make sure safari automation enabled")
    sys.exit(3)
browser.get("https://www.yuantaetfs.com/#/FundWeights/1066")
time.sleep(10) # wait until page fully loaded
# stockweights
page = browser.page_source
soup = BeautifulSoup(page, 'html.parser')
browser.quit()
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

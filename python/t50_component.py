#!/usr/bin/python3

# python3 t50_component.py
# get TAIEX 50 components
# return 0: success

import sys, requests, time, os
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

if ( len(sys.argv) < 2 ):
    print("usage: t50_component.py [ticker]")
    sys.exit(0)
#ticker = sys.argv[1]

new_table=[]

DIR0="./datafiles" # consider compatible with rank.sh
fname = "t50."+sys.argv[1]+".html"
o_fname = "t50."+sys.argv[1]+".txt" # // FIXME: compatible with rank.sh in csv
path = os.path.join(DIR0, fname)
o_path = os.path.join(DIR0, o_fname)
source_from_net = 1
if ( source_from_net == 1 ):
    browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
    if ( browser is None ):
        print("make sure safari automation enabled")
        sys.exit(3)
    # url = 'https://www.yuantaetfs.com/product/detail/0050/ratio'
    # url = 'https://www.cmoney.tw/etf/e210.aspx?key=0050'
    url = 'https://www.cmoney.tw/etf/tw/0050/fundholding'
    browser.get(url)
    time.sleep(3) # wait until page fully loaded

    # stockweights
    page = browser.page_source
    soup = BeautifulSoup(page, 'html.parser')
    browser.close()
    with open(path, "w") as outfile:
        outfile.write(soup.prettify())
    outfile.close()
else:
    with open(path) as fp:
        soup = BeautifulSoup(fp, 'html.parser')

ths=soup.find_all("thead", {})[0] \
    .find_all("th")
row=[]
row.append( ths[0].text.strip() + ths[1].text.strip() )
row.append( ths[2].text.strip() )
new_table.append(row)

# table = soup.find_all("table", {})
# table = soup.find_all("tbody", {})
rows = soup.find_all("tbody", {})[0] \
    .find_all("tr")
# pprint(len(rows))
for i in range(0, len(rows)):
    tds = soup.find_all("tbody", {})[0] \
    .find_all("tr")[i] \
    .find_all("td")
    if ( len( tds[0].text.strip() ) == 4 ):
        row=[]
        row.append( tds[0].text.strip() + tds[1].text.strip() )
        row.append( tds[2].text.strip() )
        new_table.append(row)

with open(o_fname, "w") as outfile:
    # outfile.write(soup.prettify())
    for row in new_table:
        tkr_name = row[0]
        weight   = row[1]
        outfile.write( tkr_name + ":" + weight + '\n' )
outfile.close()
print("done.")
# // TODO: combine a0050.py as one
sys.exit(0)

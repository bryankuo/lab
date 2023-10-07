#!/usr/bin/python3

# python3 t50_component.py [yyyymmdd]
# get TAIEX 50 components
# \param out: t50.yyyymmdd.csv for merge purpose
# \param out: bountylist.t50.yyyymmdd.txt for rs purpose
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

if ( len(sys.argv) < 2 ):
    print("usage: t50_component.py [yyyymmdd]")
    sys.exit(0)

new_table=[] # for merge, rank.sh
new_table1=[] # generate bounty list for ror.sh

DIR0="./datafiles/taiex" # consider compatible with rank.sh
fname = "t50."+sys.argv[1]+".html"
path = os.path.join(DIR0, fname)

o_fname = "t50."+sys.argv[1]+".csv"
o_path = os.path.join(DIR0, o_fname)
o_fname1 = "bountylist.t50."+sys.argv[1]+".txt"
o_path1 = os.path.join(DIR0, o_fname1)

source_from_file = 1 # // FIXME: as parameter
if ( int(sys.argv[2]) == 0 ):
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

rows = soup.find_all("table", {"class":"cm-table__table cm-table__table-stripe cm-table__table-row cm-table__table-fixed cm-table__table-small"})[0] \
    .find_all("tr")
for i in range(1, len(rows)-1 ):
    tds = soup.find_all("table", {"class":"cm-table__table cm-table__table-stripe cm-table__table-row cm-table__table-fixed cm-table__table-small"})[0] \
    .find_all("tr")[i] \
    .find_all("td")
    # print( tds[0].prettify() )
    if ( len( tds[0].text.strip() ) == 4 ):
        row=[]
        row.append( tds[0].text.strip() + tds[1].text.strip() )
        row.append( tds[2].text.strip() )
        new_table.append(row)
        new_table1.append(tds[0].text.strip())

with open(o_path, "w") as outfile:
    for row in new_table:
        tkr_name = row[0]
        weight   = row[1]
        outfile.write( tkr_name + ":" + weight + '\n' )
outfile.close()

with open(o_path1, "w") as outfile:
    for row in new_table1:
        # tkr = row
        outfile.write( row + '\n' )
outfile.close()

print("done, output: " + o_path + ", there are " + str(len(new_table1)))
sys.exit(0)

#!/usr/bin/python3

# python3 m100_components.py [yyyymmdd] [net|file]
# \param in yyyymmdd
# \param in net: 0, file: 1
# return 0
# 138:3406玉晶光:555.55
# source 8, 5 pages, top 150, update everyday, market value, rank
# use selenium, and firefox example:
# https://stackoverflow.com/a/36027884

import sys, requests, time, re, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException

if ( len(sys.argv) < 2 ):
    print("usage: m100_component.py [yyyymmdd] [net|file]")
    sys.exit(0)

DIR0="./datafiles/taiex" # consider compatible with rank.sh
fname = "m100."+sys.argv[1]+".html"
path = os.path.join(DIR0, fname)

# server as OUTF5 in rank.sh
o_fname = "m100."+sys.argv[1]+".csv"
o_path = os.path.join(DIR0, o_fname)

# server as OUTF7 in rank.sh
o_fname1 = "bountylist.m100."+sys.argv[1]+".txt"
o_path1 = os.path.join(DIR0, o_fname1)

new_table=[] # for merge, rank.sh
new_table1=[] # generate bounty list for ror.sh

try:
    # source 1: quote
    # https://pchome.megatime.com.tw/group/mkt5/cidE003_2.html
    # source 2: update daily
    # https://www.wantgoo.com/index/%5E543/stocks
    # source 3: with rank, monthly update
    # https://www.moneydj.com/ETF/X/Basic/Basic0007a.xdjhtm?etfid=0051.TW
    # source 4:
    # http://moneydj.emega.com.tw/js/T50_100.htm
    # source 5: weight rank daily update
    # https://www.cmoney.tw/etf/e210.aspx?key=0051
    # source 6: quote, daily update
    # https://histock.tw/global/globalclass.aspx?mid=0&id=3

    '''
    url = "https://www.cmoney.tw/etf/e210.aspx?key=0051"
    response = requests.get(url)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    print(soup.prettify())
    # rows = soup.find_all("table", {"class": "t01"})[0] \
    #    .find_all("tr")
    sys.exit(0)
    '''
    if ( int(sys.argv[2]) <= 0 ):
        browser = webdriver.Safari( \
            executable_path = '/usr/bin/safaridriver')

        # url = "https://www.cmoney.tw/etf/e210.aspx?key=0051"
        url = "https://www.cmoney.tw/etf/tw/0051/fundholding"
        print("from {}".format(url))
        browser.get(url)
        time.sleep(3) # wait until page fully loaded ( or redirected )
        page = browser.page_source
        soup = BeautifulSoup(page, 'html.parser')
        browser.close()
        with open(path, "w") as outfile:
            outfile.write(soup.prettify())
        outfile.close()
        print("to {}".format(path))
    else:
        with open(path) as fp:
            soup = BeautifulSoup(fp, 'html.parser')

except SessionNotCreatedException as ex:
    print(str(ex))
    print('make sure safari automation enabled.')
    browser.close()

finally:
    time.sleep(1)


rows = soup.find_all("table", {"class": "cm-table__table cm-table__table-stripe cm-table__table-row cm-table__table-fixed cm-table__table-small"})[0] \
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
index = 1
for i in range(1, len(rows)-1):
    rank = str(index)
    ticker = rows[i].find_all('td')[0].text.strip()
    corp_name = rows[i].find_all('td')[1].text.strip()
    product = rows[i].find_all('td')[2].text.strip()
    weight = rows[i].find_all('td')[3].text.strip()
    if ( product != "股票" ):
        continue
    print( \
        rank + ":" + \
        ticker + corp_name + ":" + \
        weight )
    row=[]
    row.append( tds[0].text.strip() + tds[1].text.strip() )
    row.append( tds[2].text.strip() )
    new_table.append(row)
    index += 1

with open(o_path, "w") as outfile:
    outfile.write( "代號公司:權重%\n" )
    for row in new_table:
        tkr_name = row[0]
        weight   = row[1]
        outfile.write( tkr_name + ":" + weight + '\n' )
outfile.close()
print("to {}".format(o_path))

with open(o_path1, "w") as outfile:
    for row in new_table1:
        # tkr = row
        outfile.write( row + '\n' )
outfile.close()
print("to {}".format(o_path1))

# ls -lt ./datafiles/taiex/m100.20240228.html ./datafiles/taiex/m100.20240228.csv ./datafiles/taiex/bountylist.m100.20240228.txt

sys.exit(0)

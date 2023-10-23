#!/usr/bin/python3

# python3 fetch_eft_components.py [id] [net|file]
# fetch ticker ror from broker, serving ror.sh
# \param in id
# \param in 0: from internet, 1: from file
# \param out components.[id].[yyyymmdd].txt as bountylist.txt
# \param out components.[id].html
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

if ( len(sys.argv) < 3 ):
    print("usage: fetch_eft_components.py [id] [net|file]")
    sys.exit(0)
ticker = sys.argv[1]
if ( int(sys.argv[2]) == 1 ):
    is_from_net = False
elif ( int(sys.argv[2]) == 0 ):
    is_from_net = True
else:
    is_from_net = False

import sys
etf_id = sys.argv[1]
sources = [ \
#
# url = "https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm?MSCI=0"

# 00733 holdings: more pages
# https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=00733.TW
# https://www.moneydj.com/ETF/X/Basic/Basic0007B.xdjhtm?etfid=510880.SH
#
# one page
# https://www.wantgoo.com/stock/etf/00733/constituent
# https://www.wantgoo.com/stock/etf/00878/constituent
# https://www.wantgoo.com/stock/etf/0056/constituent
# https://www.wantgoo.com/stock/etf/00919/constituent
# https://www.wantgoo.com/stock/etf/0050/constituent
# https://www.wantgoo.com/stock/etf/00905/constituent

# https://www.wantgoo.com/stock/etf/ranking/fund-size
# https://www.wantgoo.com/stock/etf/ranking/fund-size?manager=國泰證券投資信託股份有限公司

# https://goodinfo.tw/tw/StockList.asp?MARKET_CAT=全部&INDUSTRY_CAT=ETF

    "https://www.wantgoo.com/stock/etf/" + etf_id + "/constituent"
]

DIR0="./datafiles/taiex"
fname = "components." + etf_id + ".html"
path = os.path.join(DIR0, fname)
ofname = "components." + etf_id + "." + datetime.today().strftime('%Y%m%d') + '.txt'
o_path = os.path.join(DIR0, ofname)

use_plain_req = False
if ( is_from_net ):
    if ( os.path.exists(path) ):
        os.remove(path) # clean up
    url = sources[0]
    if ( use_plain_req ):
        response = requests.get(url)
        # response.encoding = 'cp950'
        soup = BeautifulSoup(response.text, 'html.parser')
    else:
        try:
            browser = webdriver.Safari( \
                executable_path = '/usr/bin/safaridriver')
            # browser.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS); # // FIXME:
            browser.get(url)
            # Select(WebDriverWait(browser, 5)                                \
                    #    .until(EC.visibilityOfAllElements())) # // FIXME:
            # time.sleep(10)
            # // FIXME: wait until page fully loaded.
            per_page = Select(WebDriverWait(browser, 10)                     \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//tbody[@id='holdingTable']"))))
            page1 = browser.page_source
            soup = BeautifulSoup(page1, 'html.parser')
        except (SessionNotCreatedException):
            print('make sure allow remote is on')
        except:
            # traceback.format_exception(*sys.exc_info()) # // FIXME:
            e = sys.exc_info()[0]
            print("Unexpected error:", sys.exc_info()[0])
            raise
        finally:
            browser.quit()
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
else:
    with open(path) as q:
        soup = BeautifulSoup(q, 'html.parser')

sys.exit(0)
name = "n/a" #title["content"].split(' ')[0].split(')')[1].strip()

# apply to src 1,2,3,4
r_ytd = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[8] \
    .find_all('td')[1].text.strip().replace('%', '')

r_1w  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[9] \
    .find_all('td')[1].text.strip().replace('%', '')

r_1m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[10] \
    .find_all('td')[1].text.strip().replace('%', '')

r_2m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[11] \
    .find_all('td')[1].text.strip().replace('%', '')

r_3m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[12] \
    .find_all('td')[1].text.strip().replace('%', '')

# olist =   [ f_1d,  f_1w, f_1m, "n/a", f_3m, f_6m,  f_1y,  f_ytd, f_3y  ]
olist   =   [ "n/a", r_1w, r_1m, r_2m,  r_3m, "n/a", "n/a", r_ytd, "n/a" ]
#print(olist)
# presume get_twse_ror.py is running at first
with open(o_path, 'a') as ofile:
    # ofile.write("ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y\n")
    ofile.write(ticker+":"+name+":n/a:"+r_1w+":"+r_1m+":"+r_2m+":"+r_3m \
        +":n/a:n/a:"+r_ytd+":n/a"+"\n")
    ofile.close()
sys.exit(0)

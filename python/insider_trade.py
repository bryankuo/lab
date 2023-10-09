#!/usr/bin/python3

# python3 insider_trade.py [yyyymmdd] [net|file]
# get ticker close price by date
# \param in ticker
# \param in date in yyyymmdd
# \param in 0: from internet, 1: from file
# \param out price.[ticker].[yyyymmdd].html
# \parm  out a list containing close price
# \return 0: success

import sys, requests, time, os
import urllib.request
from datetime import timedelta, datetime, date
from bs4 import BeautifulSoup

# source
# http://jsjustweb.jihsun.com.tw/z/ze/zei/zei.djhtm
# https://www.moneydj.com/Z/ZE/ZEI/ZEI.djhtm
# https://www.sinotrade.com.tw/Stock/Stock_3_6?ch=Stock_3_6_6

if ( len(sys.argv) < 3 ):
    print("usage: insider_trade.py [yyyymmdd] [net|file]")
    sys.exit(0)

yyyymmdd = sys.argv[1]
if ( int(sys.argv[2]) == 1 ):
    is_from_net = False
elif ( int(sys.argv[2]) == 0 ):
    is_from_net = True
else:
    is_from_net = False
use_plain_req = True

DIR0="./datafiles/taiex" # consider compatible with rank.sh
fname = "insider_trade."+yyyymmdd+".html"
path = os.path.join(DIR0, fname)

url = "http://jsjustweb.jihsun.com.tw/z/ze/zei/zei.djhtm"

if ( is_from_net ):
    if ( os.path.exists(path) ):
        os.remove(path) # clean up
    # url = select_src( ticker, random.randint(1,4) )
    if ( use_plain_req ):
        response = requests.get(url)
        # response.encoding = 'cp950'
        soup = BeautifulSoup(response.text, 'html.parser')
    else:
        browser = webdriver.Safari( \
            executable_path = '/usr/bin/safaridriver')
        browser.get(url)
        time.sleep(1)
        page1 = browser.page_source
        soup = BeautifulSoup(page1, 'html.parser')
        browser.quit()
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
else:
    with open(path) as q:
        soup = BeautifulSoup(q, 'html.parser')
'''
close_price = 0
req_date_format = '%Y%m%d'
req_date_obj = datetime.strptime(yyyymmdd, req_date_format)
#print(req_date_obj)
table_body = soup.find('tbody')
if ( table_body is not None ):
    for tr in soup.findAll('tr')[2:]:
        tds = tr.findAll('td')
        dt_s = tds[0].text.replace('\n','').strip()
        this_date = date( int(dt_s[0:3])+1911, int(dt_s[4:6]), int(dt_s[7:9]) )
        # print(this_date)
        if ( this_date.day == req_date_obj.day ):
            close_price = float(tds[6].text.replace(',', ''))
            break
'''
olist = [ 0 ]
print(olist)
sys.exit(0)

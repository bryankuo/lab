#!/usr/bin/python3

# python3 price_otc.py [ticker] [yyyymmdd] [net|file]
# get type 4 ticker close price by date
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
# https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=html&date=20231007&stockNo=1102

if ( len(sys.argv) < 4 ):
    print("usage: price_otc.py [ticker] [yyyymmdd] [net|file]")
    sys.exit(0)

ticker = sys.argv[1]
yyyymmdd = sys.argv[2]
print("price_otc+ {} {} {}".format(ticker, yyyymmdd, sys.argv[3]))
if ( int(sys.argv[3]) == 1 ):
    is_from_net = False
elif ( int(sys.argv[3]) == 0 ):
    is_from_net = True
else:
    is_from_net = False
use_plain_req = True

DIR0="./datafiles/taiex" # consider compatible with rank.sh
fname = "price."+ticker+"."+yyyymmdd+".html"
path = os.path.join(DIR0, fname)

# https://www.tpex.org.tw/web/stock/aftertrading/daily_trading_info/st43.php?l=zh-tw
# https://www.tpex.org.tw/web/stock/aftertrading/daily_trading_info/st43_print.php?l=zh-tw&d=112/11&stkno=3402&s=0,asc,0

url = "https://www.tpex.org.tw/web/stock/" + \
    "aftertrading/daily_trading_info/st43_print.php?l=zh-tw&d=" + \
    str(int(yyyymmdd[0:4])-1911) + "/" + yyyymmdd[4:6] + \
    '&stkno=' + ticker + '&s=0,asc,0'

if ( is_from_net ):
    if ( os.path.exists(path) ):
        os.remove(path) # clean up
    # print(url)
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

close_price = 0
req_date_format = '%Y%m%d'
req_date_obj = datetime.strptime(yyyymmdd, req_date_format)
#print(req_date_obj)
rows = soup.find_all("table")[0] \
    .find_all("tbody")[0].find_all("tr")

if ( rows is not None ):
     for tr in rows:
        tds = tr.findAll('td')
        dt_s = tds[0].text.replace('\n','').strip()
        this_date = date( int(dt_s[0:3])+1911, int(dt_s[4:6]), int(dt_s[7:9]) )
        if ( this_date.day == req_date_obj.day ):
            close_price = float(tds[6].text.replace(',', ''))
            break
olist = [ close_price ]
print(olist)
sys.exit(0)

#!/usr/bin/python3

# python3 fetch_margin_balance.py
# fetch ticker margin balance html from sites, on daily bases
# serving scrap_market_value.sh // TODO:
# rotating user agents
# \param in  datafiles/taiex/margin_balance/yyyymmdd folder
# \param out [ticker].html
# \param out list to diff day by day
# return 0

# security lending
# https://www.twse.com.tw/zh/products/sbl/disclosures/t13sa710.html

# 融資融券明細
# 融資維持率 計算 市值/融資餘額
# filter between 140% - 120%
#
# margin
# https://concords.moneydj.com/z/zc/zcn/zcn_1101.djhtm
# https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcn/zcn_2881.djhtm

import os, sys, requests, time, numpy, random, csv, timeit
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta, datetime
from pprint import pprint
sys.path.append(os.getcwd())
import useragents as ua
import sites # // TODO: as well as url

DIR0="./datafiles/taiex/margin_balance"
if not os.path.exists(DIR0):
    os.mkdir(DIR0)

DIR2 = os.path.join(DIR0, datetime.today().strftime('%Y%m%d'))
if not os.path.exists(DIR2):
    os.mkdir(DIR2)

path1  = "./datafiles/watchlist.txt"

ofname1 = "log.txt"
log_path = os.path.join(DIR2, ofname1)

l_fname = "fetched.txt"
list_path = os.path.join(DIR2, l_fname)

conn_list = [1] * len(sites.list)
conn = 0

def source_factory(ticker):
    # update connectivity dynamically
    # if connection error then update to 0, avoid repeating error
    conn = random.randint(0, len(sites.list)-1)
    while ( conn_list[conn] <= 0 ):
        conn = random.randint(0, len(sites.list)-1)

    page = "/z/zc/zcn/zcn_" + ticker + ".djhtm"
    url = sites.list[conn] + page

    '''
    # verify all sites in a round-robin way
    for conn in range(0, len(sites.list)-1):
        url = sites.list[conn] + page
        print(url)
    '''
    return url

f = open(path1, 'r'); logf = open(log_path, 'w'); lst = open(list_path, 'w')
session = None; count = 0; fname = ""; path = ""

for ticker in f:
    ticker = ticker.replace('\n','')
    fetch_not_ok = True
    while fetch_not_ok:
        headers = {'User-Agent': random.choice(ua.list)}
        url = source_factory(ticker)
        try:
            if session is None:
                # response = requests.get(url)
                response = requests.get(url, headers=headers)
                session = requests.Session()
            else:
                # response = session.get(url)
                response = session.get(url, headers=headers)
            response.encoding = 'cp950'
            soup = BeautifulSoup(response.text, 'html.parser')
            fname = ticker + ".html"
            path = os.path.join(DIR2, fname)
            outfile2 = open(path, "w")
            outfile2.write(soup.prettify())
            outfile2.close()

        except requests.exceptions.ConnectionError:
            e = sys.exc_info()[0]
            print("Unexpected error:", sys.exc_info()[0])
            conn_list[conn] = 0
            raise

        except:
            # traceback.format_exception(*sys.exc_info())
            e = sys.exc_info()[0]
            print("Unexpected error:", sys.exc_info()[0])
            raise

        finally:
            # @see https://stackoverflow.com/a/50223400
            s = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')
            d = datetime.strptime(s, '%Y%m%d %H:%M:%S.%f').strftime('%s.%f')
            d_in_ms = int(float(d)*1000)
            # print(d_in_ms)
            # print(datetime.fromtimestamp(float(d)))
            ts = datetime.fromtimestamp(float(d))
            sz = os.path.getsize(path)
            msg = "{} {:04} {:4} {} {:>5} {}" \
                .format(ts, count, ticker, response.status_code, sz, url)
            print(msg)
            logf.write(msg+"\n") # // FIXME: scan fetch log
            if ( response.status_code <= 200 ):
                count += 1
                fetch_not_ok = False
                lst.write(ticker+"\n")

# // @see https://stackoverflow.com/a/49253627
session.close();
f.close(); logf.close(); lst.close()
print("total # fetched {}".format(count))
print("./scrap_margin_balance.sh [yyyymmdd] to continue ...")
sys.exit(0)

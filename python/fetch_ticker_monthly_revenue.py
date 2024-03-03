#!/usr/bin/python3

# python3 fetch_ticker_monthly_revenue.py
# fetch ticker monthly revenue html from sites.
# rotating user agents
# \param in  datafiles/taiex/monthly_revenue/yyyymmdd folder
# \param out [ticker].html
# \param out list to diff day by day
# return 0

import os, sys, requests, time, numpy, random, csv, timeit
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta, datetime
from pprint import pprint
sys.path.append(os.getcwd())
import useragents as ua
import sites # // TODO: as well as url

'''
# try again when market is open
https://sjmain.esunsec.com.tw/z/zc/zch/zch_5203.djhtm
'''

DIR0="./datafiles/taiex/monthly_revenue"
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
    # url = random.choice(sites.list) + page

    '''
    # update connectivity dynamically
    # if connection error then update to 0, avoid repeating error
    conn = random.randint(0, len(sites.list)-1)
    while ( conn_list[conn] <= 0 ):
        conn = random.randint(0, len(sites.list)-1)
    '''

    '''
    # verify all sites in a round-robin way
    conn += 1
    if ( len(sites.list) <= conn ):
        conn = 0
    '''
    page = "/z/zc/zch/zch_" + ticker + ".djhtm"
    for conn in range(0, len(sites.list)-1):
        url = sites.list[conn] + page
        print(url)
    sys.exit(0)
    return url

f = open(path1, 'r'); logf = open(log_path, 'w'); lst = open(list_path, 'w')
session = None; count = 0; fname = ""; path = ""

for ticker in f:
    ticker = ticker.replace('\n','')
    print("{}".format(ticker))
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
            # response.encoding = 'cp950'
            # time.sleep(1) # // FIXME: random time
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
                # break

# // @see https://stackoverflow.com/a/49253627
session.close();
f.close(); logf.close(); lst.close()
sys.exit(0)

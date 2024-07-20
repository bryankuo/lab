#!/usr/bin/python3

# python3 insider_trade.py [yyyymmdd] [net|file]
# identify tickers with insider trade this week
# // TODO: automate updating activities
# // TODO: 從身份跟轉讓方式to identify those possible good at trading
# \param in date in yyyymmdd
# \param in 0: from internet, 1: from file
# \param out datafiles/taiex/insider_trade.[yyyymmdd].html, assuming on Sat.
#
# \parm  out a list containing close price
# \return 0: success

import sys, requests, time, os, re, random, webbrowser
import urllib.request
from datetime import timedelta, datetime, date
from bs4 import BeautifulSoup
from pprint import pprint
sys.path.append(os.getcwd())
import useragents as ua
import sites

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

DIR0="./datafiles/taiex" # consider compatible with rank.sh
fname = "insider_trade."+yyyymmdd+".html"
path = os.path.join(DIR0, fname)

this_date = date( int(yyyymmdd[0:4]), int(yyyymmdd[4:6]), int(yyyymmdd[6:8]) )
# print(this_date)
# print(this_date.weekday())
idx = (this_date.weekday() + 1) % 7
last_sat = this_date - timedelta(7+idx-6)
# @see https://stackoverflow.com/a/18200686


# source
# https://www.moneydj.com/Z/ZE/ZEI/ZEI.djhtm
# https://www.sinotrade.com.tw/Stock/Stock_3_6?ch=Stock_3_6_6
# url = "https://sjmain.esunsec.com.tw/z/ze/zei/zei.djhtm" # running
# https://www.esunsec.com.tw/tw-rank/z/ZG/ZG_AB.djhtm # down
# sites.test() # works

if ( is_from_net ):
    url = random.choice(sites.list) + "/z/ze/zei/zei.djhtm"
    print("from {}".format(url))
    if ( os.path.exists(path) ):
        os.remove(path) # clean up
    # response = requests.get(url)
    user_agent = random.choice(ua.list)
    headers = {'User-Agent': user_agent}
    response = requests.get(url, headers=headers)

    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    # print("to {}".format(path))
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
    outfile2.close()
    # inspection / confirmation purpose
    webbrowser.open(url)

else:
    with open(path) as q:
        soup = BeautifulSoup(q, 'html.parser')

rows = soup.find_all("table", {"class": "t01"})[0] \
        .find_all("tr")
# print("# rows {}".format(len(rows)))
num_this_wk = 0
last_ticker = 0
num_ticker = 0
tkr_l = []
for i in range(2, len(rows)-1):
    mm = rows[i].find_all('td')[0].text.strip()[0:2]
    dd = rows[i].find_all('td')[0].text.strip()[3:5]
    # // FIXME: end of year to a new one
    the_date = date( int(yyyymmdd[0:4]), int(mm), int(dd) )
    td = str(rows[i].find_all('td')[1])
    # @see https://stackoverflow.com/a/65561465
    the_ticker = int( re.search('\(([^)]+)', td).group(1) \
        .split(',')[0].split('\'')[1].split("AS")[1] )
    # print("{:03d} {}".format(i, the_ticker))
    tkr_l.append(the_ticker)

tkr_l = set(tkr_l)
print("in the order of date desc:")
pprint("{}".format(tkr_l))
# // TODO: recent day -7 d, date, ticker, whois, type of t. to df
sys.exit(0)

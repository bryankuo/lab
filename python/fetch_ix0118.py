#!/usr/bin/python3

# python3 fetch_ix0118.py [net|file]
#
# there are 2 steps, 1: from net, 2: scrap from file
#
# \param in 0 net 1 file
# \param out csv file
#

import sys, requests, datetime, time, numpy, random, csv, urllib
import os, errno
import pandas as pd
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint
from array import *
sys.path.append(os.getcwd())
import useragents as ua

if ( len(sys.argv) < 1 ):
    print("python3 fetch_ix0118.py [net|file]")
    sys.exit(0)


DIR0="./datafiles/taiex"

try:
    os.makedirs(DIR0)
except OSError as exc:
    if exc.errno == errno.EEXIST and os.path.isdir(DIR0):
        pass

from_file     = True
if ( int(sys.argv[1]) == 0 ):
    from_file     = False

html_path = os.path.join(DIR0, 'ix0118.html')

list1   = []
list100 = []
listix0118 = []

if ( from_file ):
    print("read {}".format(html_path))
    fp = open(html_path, 'r')
    soup = BeautifulSoup(fp, 'html.parser')
    rows = soup.find_all("table", {"class": "table_c"})[0].find_all("tr")
    # print("# rows: {}".format(len(rows)))
    # pprint(rows[0])
    ths = rows[0].find_all("th")
    # print("# ths: {}".format(len(ths)))
    tl0 = ths[0].text.strip()
    tl1 = "代號"
    tl2 = ths[1].text.strip()
    tl3 = ths[2].text.strip()
    print("{} {} {} {}".format(tl0, tl1, tl2, tl3))
    for i in range(1, len(rows)):
        tds = rows[i].find_all("td")

        rk1  = tds[0].text.strip()
        tkr1 = tds[1].text.strip()
        nm1  = tds[2].text.strip()
        wt1  = tds[3].text.strip()

        rk1x  = tds[4].text.strip()
        tkr1x = tds[5].text.strip()
        nm1x  = tds[6].text.strip()
        wt1x  = tds[7].text.strip()

        list1.append([rk1, tkr1, nm1, wt1])
        if ( 0 < len(rk1x) ):
            list100.append([rk1x, tkr1x, nm1x, wt1x])

    listix0118 = list1 + list100
    pprint(listix0118)
    df = pd.DataFrame(listix0118, columns=[tl0, tl1, tl2, tl3])
    pprint(df)
    opath = os.path.join(DIR0, 'ix0118.component.csv')
    df.to_csv(opath, sep = ':', header=True, index=False)
    print("{} write to {}".format(df.shape, opath))

else:
    url = "https://www.taifex.com.tw/cht/2/g2FPropertion"
    print(url)
    # response = requests.get(url)
    headers = {'User-Agent': random.choice(ua.list)}
    response = requests.get(url, headers=headers)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    print(html_path)
    outfile2 = open(html_path, "w")
    outfile2.write(soup.prettify())
    outfile2.close()

sys.exit(0)

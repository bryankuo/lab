#!/usr/bin/python3

# python3 get_ticker_monthly_revenue.py [ticker] [yyyymmdd]
# scraping market value from file fetched ror html
# \param in      ticker
# \param in      yyyymmdd
# \param in      [ticker].html by fetch_ticker_monthly_revenue.py
# \param out     "./datafiles/taiex/monthly_revenue/YYYYMMDD.csv", daily bases
# 市值單位:仟元
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

if ( len(sys.argv) < 3 ):
    print("usage: get_ticker_monthly_revenue.py [ticker] [yyyymmdd]")
    sys.exit(0)
ticker   = sys.argv[1]
yyyymmdd = sys.argv[2]

DIR0="./datafiles/taiex/monthly_revenue"
DIR1 = os.path.join(DIR0, yyyymmdd)

fname = ticker + ".html"
h_path = os.path.join(DIR1, fname)

# gen by scrap_monthly_revenue.sh, then append one line at a time
mr_fname = yyyymmdd + ".0.csv"
m_path  = os.path.join(DIR0, mr_fname)
q = open(h_path)
soup = BeautifulSoup(q, 'html.parser') # // FIXME: chinese encoding

rows = soup.find_all("table", {"id": "oMainTable", "class": "t01"})[0] \
    .find_all("tr")

name = rows[0] \
    .find_all('td')[0].text.split('(')[0].strip()
# print("{}".format(name))

ym = rows[6] \
    .find_all('td')[0].text.strip().replace(',', '')
# print("{}".format(ym))

mr = rows[6] \
    .find_all('td')[1].text.strip().replace(',', '')
# print("{}".format(mr))

momp = rows[6] \
    .find_all('td')[2].text.strip().replace(',', '') # .replace('%', '')
# print("{}".format(momp))

yoyp = rows[6] \
    .find_all('td')[4].text.strip().replace(',', '') # .replace('%', '')
# print("{}".format(yoyp))

ofile = open(m_path, 'a')
ofile.write(ticker+":"+name+":"+ym+":"+momp+":"+yoyp+":"+mr+"\n")
ofile.close()

sys.exit(0)

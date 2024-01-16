#!/usr/bin/python3

# python3 rs_wrt_twse.py [yyyymmdd]
# scraping from file fetched and compare with twse in rs
# \param in     YYYYMMDD.html
# \param in     YYYYMMDD.all.columns.csv
# \param out    YYYYMMDD.rs.csv
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
'''
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
'''
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

if ( len(sys.argv) < 2 ):
    print("usage: rs_wrt_twse.py [yyyymmdd]")
    sys.exit(0)

yyyymmdd = sys.argv[1]

DIR0r="./datafiles/taiex/rs"
DIR0a="./datafiles/taiex/after.market"

fname = yyyymmdd + ".html"
h_path = os.path.join(DIR0a, fname)

cname = yyyymmdd + ".all.columns.csv"
c_path = os.path.join(DIR0a, cname)

rs_fname  = "rs.wrt.twse."  + yyyymmdd + '.price.desc.csv'
rs_path   = os.path.join(DIR0r, rs_fname)

print("read {}".format(h_path))
in_html = open(h_path, 'r')
soup = BeautifulSoup(in_html, 'html.parser')
pinfo = soup.find_all("div", {"class": "info-right ftR"})[0] \
    .find_all("div")[0] \
    .find_all('ul')[0]
# twse_mark = float( pinfo.find_all('li')[0] \
#     .find_all('span')[1].text.strip() )
twse_chg = float( pinfo.find_all('li')[2] \
    .find_all('span')[1].text.strip().replace('%','') )
# print(len(pinfo))
# print(twse_chg)
print("twse {}".format(twse_chg)) # works
in_html.close()

print("read {}".format(c_path))
in_csv = open(c_path, 'r')
data = list(csv.reader(in_csv, delimiter=':'))
tkrs = [ x[0] for x in data ]
chgs = [ x[4] for x in data ]

outf_rs = open(rs_path, 'w')
outf_rs.write("{}:{}\n".format("ticker","rs"))
for i in range(1, len(tkrs)):
    if ( chgs[i] != "--" ):
        ticker_chg = chgs[i].replace('%','')
        ticker_rs = (float(ticker_chg)-float(twse_chg))/abs(float(twse_chg))
    else:
        ticker_rs = "n/a"
    outf_rs.write("{}:{}\n".format(tkrs[i],ticker_rs))
in_csv.close()
outf_rs.close()
print("write to {}".format(rs_path))
sys.exit(0)

#!/usr/bin/python3

# python3 get_bhr.py [ticker] [yyyymmdd]
# scraping from file fetched, extract ratio, and append to another csv
# \param in      ticker
# \param in      yyyymmdd
# \param in      [ticker].html
# \param out     bholding.csv
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

if ( len(sys.argv) != 3 ):
    print("usage: get_bhr.py [ticker] [yyyymmdd]")
    sys.exit(0)

ticker   = sys.argv[1]
yyyymmdd = sys.argv[2]

DIR0="./datafiles/taiex/board.holding"
DIR1 = os.path.join(DIR0, yyyymmdd)

hname  = ticker + ".html"
h_path = os.path.join(DIR1, hname)

ofname = "bholding.csv"
o_path = os.path.join(DIR1, ofname)

outf = open(o_path, 'a'); inf = open(h_path, "r")

soup = BeautifulSoup(inf, 'html.parser')
# print("# of table: {}".format(len(soup.findAll('table'))))
tbl = soup.find_all("table", {"class": "t01"})
# print("# of t01: {}".format(len(tbl)))
r = soup.find_all("table", {"class": "t01"})[0] \
    .find_all("tr")[2] \
    .find_all("td")[3].text.strip().replace('%','')
# print("{}".format(r))
outf.write( "{}:{}".format(ticker, r) + "\n" )
inf.close(); outf.close()
sys.exit(0)

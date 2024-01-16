#!/usr/bin/python3

# python3 extract_limit_updown.py [yyyymmdd]
# scraping from file fetched and compare with twse in rs
# \param in     YYYYMMDD.html
# \param in     YYYYMMDD.all.columns.csv
# \param out    quote, volume, RS wrt. TWSE
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta, datetime
from pprint import pprint
import pandas as pd
pd.options.mode.chained_assignment = None  # default='warn'
# @see https://stackoverflow.com/a/20627316

if ( len(sys.argv) < 2 ):
    print("usage: extract_limit_updown.py [yyyymmdd]")
    sys.exit(0)

yyyymmdd = sys.argv[1]

# DIR0r="./datafiles/taiex/rs"
DIR0a="./datafiles/taiex/after.market"

# fname = yyyymmdd + ".html"
# h_path = os.path.join(DIR0a, fname)

cname = yyyymmdd + ".all.columns.csv"
c_path = os.path.join(DIR0a, cname)
# cname1 = yyyymmdd + ".full.rs.csv"
# opath = os.path.join(DIR0a, cname1)

# rs_fname  = "extract_limit_updown."  + yyyymmdd + '.price.desc.csv'
# rs_path   = os.path.join(DIR0r, rs_fname)

limit_ulist = []; limit_dlist = [];
print("read {}".format(c_path))
df = pd.read_csv(c_path, sep=':', skiprows=0, header=0)
# print(df.shape)
for i in range(0, len(df.index)):
    # print(df.loc[[i]])
    if ( df.loc[i,'漲跌幅'] != "--" ):
        r0 = float(df.loc[i,'漲跌幅'].replace('%',''))
        l_threshold = 9.1
        if ( l_threshold <= r0 ):
            limit_ulist.append(int(df.loc[i,'代號']))
        if ( r0 <= -l_threshold ):
            limit_dlist.append(int(df.loc[i,'代號']))

pprint("u {} {}".format(len(limit_ulist), limit_ulist))
pprint("d {} {}".format(len(limit_dlist), limit_dlist))

sys.exit(0)

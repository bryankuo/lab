#!/usr/bin/python3

# python3 count_n_luld.py [yyyymmdd]
# count number of limit up ( down )
#
# \param in yyyy+mm+dd + ".all.columns.csv" from after_market.py

import sys, requests, datetime, time, numpy, random, csv, urllib
import os, errno
from pprint import pprint
import pandas as pd

if ( len(sys.argv) < 1 ):
    print("python3 count_n_luld.py [yyyymmdd]")
    sys.exit(0)

yyyymmdd = sys.argv[1]

DIR0a="./datafiles/taiex/after.market"
cname = yyyymmdd + ".all.columns.csv"
c_path = os.path.join(DIR0a, cname)
print("read {}".format(c_path))
close_hlist = []; close_llist = []
limit_ulist = []; limit_dlist = []

df = pd.read_csv(c_path, sep=':', skiprows=0, header=0)
for i in range(0, len(df.index)):
    # print(df.loc[[i]])
    if ( df.loc[i,'漲跌幅'] != "--" ):
        cls = float(df.loc[i,'價格'])
        h   = float(df.loc[i,'最高'])
        l   = float(df.loc[i,'最低'])
        r0 = float(df.loc[i,'漲跌幅'].replace('%',''))
        if ( cls == h ):
            close_hlist.append(int(df.loc[i,'代號']))
            if ( 9.66 <= r0 ):
                limit_ulist.append(int(df.loc[i,'代號']))
        elif ( cls == l ):
            close_llist.append(int(df.loc[i,'代號']))
            if ( r0 <= -9.66 ):
                limit_dlist.append(int(df.loc[i,'代號']))

print("# limit day high {}".format(len(limit_ulist)))
pprint("{}".format(limit_ulist))

print("# limit day low  {}".format(len(limit_dlist)))
pprint("{}".format(limit_dlist))

print("# close day high {}".format(len(close_hlist)))
print("# close day low  {}".format(len(close_llist)))
sys.exit(0)

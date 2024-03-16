#!/usr/bin/python

# slice ticker and # days from last high
#
# \param in activity_watchlist.ods
# \param in d1
# \param in d0
# \param out

import sys, os, time

# @see https://stackoverflow.com/a/15778297
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

import pandas as pd
from pprint import pprint
from datetime import datetime

if ( len(sys.argv) < 3 ):
    print("usage: slice_last_high.py [d1] [d0]")
    sys.exit(0)

d1 = sys.argv[1]
d0 = sys.argv[2]

DIR0 = "datafiles"
DIR0a = "datafiles/taiex/after.market"

if False :
    activity="activity_watchlist.ods"
    ipath = os.path.join(DIR0, activity)
    print("reading {} ...".format(ipath))
    # t0 = time.time_ns() / (10 ** 9)
    # t0 = time.time_ns()
    t0 = time.time()
    # @see https://stackoverflow.com/a/18406412
    t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
    df = pd.read_excel( \
        ipath, sheet_name='20231211', \
        engine="odf")
    # print("size: " + str(len(df)))
    # t1 = time.time_ns()
    # print("{:>.0f} nanoseconds".format(t1-t0))
    # print("{:,} nanoseconds".format(t1-t0))
    t1 = time.time()
    hours, rem = divmod(t1-t0, 3600)
    minutes, seconds = divmod(rem, 60)
    print("start: " + t_start)
    print( "{:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )
    # pprint(df)
    # print(df.dtypes)
    df1 = df[['代號', '創新高天數']] # remark not allowed
    # pprint(df1)
    # ts = datetime.now().strftime('%Y%m%d')

    '''
    ndays_high = "ndays_high." + ts + ".ods"
    opath = os.path.join(".", ndays_high) # DIR0
    print("writing {} ...".format(opath))
    doc = pd.ExcelWriter(opath, engine="odf")
    df1.to_excel(doc, sheet_name="創新高天數")
    doc.close()
    '''

f1 = d1 + ".all.columns.csv"
ipath1 = os.path.join(DIR0a, f1)
if ( not os.path.exists(ipath1) ):
    print("{} not found".format(ipath1))
    sys.exit(0)
print("reading {} ...".format(ipath1))
t0 = time.time()
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
df2 = pd.read_csv(ipath1, sep=':', skiprows=0, header=0)
dfd1 = df2[['代號', '最高']]
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print("start: " + t_start)
print( "{:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )
print(dfd1.columns)

f0 = d0 + ".all.columns.csv"
ipath1 = os.path.join(DIR0a, f0)
if ( not os.path.exists(ipath1) ):
    print("{} not found".format(ipath1))
    sys.exit(0)
print("reading {} ...".format(ipath1))
t0 = time.time()
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
df0 = pd.read_csv(ipath1, sep=':', skiprows=0, header=0)
dfd0 = df0[['代號', '最高']]
# print(dfd0.dtypes)
# pprint(dfd0)
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print("start: " + t_start)
print( "{:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )
# print(dfd0.columns)

# diff = dfd1.compare(dfd0)
# print(diff)

# merged = dfd1.merge(dfd0, indicator=True, how='outer')
# merged[merged['_merge'] == 'right_only']
# print(merged)

# newly added
df3 = dfd1.merge(dfd0, on='代號', how='left', indicator=True)
df3 = df3.query('_merge == "left_only"').drop('_merge', 1)
print("newly added:")
print(df3)

# de-listed? // TODO:
df4 = dfd0.merge(dfd1, on='代號', how='left', indicator=True)
df4 = df4.query('_merge == "left_only"').drop('_merge', 1)
print("de-listed:")
print(df4)

# 上一個比現在高的價格是出現在幾天之前
# ( 負值表示創新低 )


sys.exit(0)

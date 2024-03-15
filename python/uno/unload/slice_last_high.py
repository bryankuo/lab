#!/usr/bin/python

# slice ticker and # days from last high
# playground of pandas dataframe odfpy function

import sys, os, time
import pandas as pd
from pprint import pprint
from datetime import datetime

'''
DIR0 = "datafiles"
activity="activity_watchlist.ods"
ipath = os.path.join(DIR0, activity)
print("reading {} ...".format(ipath))
# t0 = time.time_ns() / (10 ** 9)
# t0 = time.time_ns()
t0 = time.time()
# @see https://stackoverflow.com/a/18406412
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
# df = pd.read_csv(ipath, sep=':', skiprows=0, header=0)
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
print(df.dtypes)
df1 = df[['代號', '創新高天數']] # remark not allowed
pprint(df1)
'''
ts = datetime.now().strftime('%Y%m%d')
'''
ndays_high = "ndays_high." + ts + ".ods"
opath = os.path.join(".", ndays_high) # DIR0
print("writing {} ...".format(opath))
doc = pd.ExcelWriter(opath, engine="odf")
df1.to_excel(doc, sheet_name="創新高天數")
doc.close()
'''
DIR0a = "datafiles/taiex/after.market"
f1 = ts + ".all.columns.csv"
ipath1 = os.path.join(DIR0a, f1)
if ( not os.path.exists(ipath1) ):
    print("{} not found".format(ipath1))
    sys.exit(0)
print("reading {} ...".format(ipath1))
# df2 = pd.read_csv(ipath1, sep=':', skiprows=0, header=['代號', '最高'])
# df2 = pd.read_csv(ipath1, sep=':', header=['代號', '最高'])
df2 = pd.read_csv(ipath1, sep=':', skiprows=0, header=0)
df2a = df2[['代號', '最高']]
print(df2a.dtypes)
pprint(df2a)
# 上一個比現在高的價格是出現在幾天之前
# ( 負值表示創新低 )

sys.exit(0)

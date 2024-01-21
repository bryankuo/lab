#!/usr/bin/python

# Hello world python program
# playground of pandas dataframe odfpy function

import sys, os, time
import pandas as pd
from pprint import pprint
from datetime import datetime

# print("Hello World!")
# activity="datafiles/activity_watchlist.ods"

# df=pd.read_excel("1.ods", engine="odf")

# df = pd.read_excel(activity, engine="odf")

# df = pd.read_excel(activity, \
#     sheet_name='台股近一個月申轉筆數', \
#    engine="odf")

# reading csv, assume post running "after_market.py 1"
DIR0 = "./datafiles/taiex/after.market"
yyyymmdd = sys.argv[1]
ipath = os.path.join(DIR0, yyyymmdd + '.all.columns.csv')
print("reading {} ...".format(ipath))

# t0 = time.time_ns() / (10 ** 9)
# t0 = time.time_ns()
t0 = time.time()
# @see https://stackoverflow.com/a/18406412
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
df = pd.read_csv(ipath, sep=':', skiprows=0, header=0)
# t1 = time.time_ns()
# print("{:>.0f} nanoseconds".format(t1-t0))
# print("{:,} nanoseconds".format(t1-t0))
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print("start: " + t_start)
print( "{:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )

pprint(df)

sys.exit(0)

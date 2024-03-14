#!/usr/bin/python

# slice ticker and # days from last high
# playground of pandas dataframe odfpy function

import sys, os, time
import pandas as pd
from pprint import pprint
from datetime import datetime

# print("Hello World!")
DIR0 = "datafiles"
activity="activity_watchlist.ods"
ipath = os.path.join(DIR0, activity)
print("reading {} ...".format(ipath))

# df=pd.read_excel("1.ods", engine="odf")

#

# df = pd.read_excel(activity, \
#     sheet_name='台股近一個月申轉筆數', \
#    engine="odf")



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
# df1 = df.loc[:, ['代號', '創新高天數']]
# df1 = df[['代號', '市值', '創新高天數']]
# df1 = df[['代號']] # works
# df1 = df[['市值']] # NG
pprint(df[['代號', '市值', '創新高天數']]) # remark not allowed
# 上一個比現在高的價格是出現在幾天之前
# ( 負值表示創新低 )

sys.exit(0)

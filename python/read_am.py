#!/usr/bin/python

# python3 read_am.py [yyyymmdd]
# \param in date, yyyymmdd
# \param out pandas df
#
# reading csv, assume post running "after_market.py 1"
#
# return 0

import sys, os, time
import pandas as pd
from pprint import pprint
from datetime import datetime

DIR0 = "./datafiles/taiex/after.market"
yyyymmdd = sys.argv[1]
ipath = os.path.join(DIR0, yyyymmdd + '.all.columns.csv')
print("reading {} ...".format(ipath))

t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
t0 = time.time()
df = pd.read_csv(ipath, sep=':', skiprows=0, header=0)
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print("start: " + t_start)
print( "{:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )

pprint(df)

sys.exit(0)

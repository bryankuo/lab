#!/usr/bin/python

# python3 rw_am.py [yyyymmdd]
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
import numpy as np

DIR0 = "./datafiles/taiex/after.market"
yyyymmdd = sys.argv[1]
ipath = os.path.join(DIR0, yyyymmdd + '.all.columns.csv')
print("reading {} ...".format(ipath))

t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
df = pd.read_csv(ipath, sep=':', skiprows=0, header=0)
pprint(df)
print(df.dtypes)

# df = df.convert_objects(convert_numeric=True)
# "--" inside
# df['漲跌幅'] = df['漲跌幅'].str.replace('%','').astype(np.float64)
# NaN
df['漲跌幅'] = pd.to_numeric(df['漲跌幅'].str.replace('%',''), errors='coerce')

print(df.dtypes)
print(df.iloc[1]['漲跌幅'])
pprint(df)

opath = yyyymmdd+'.ods'
print("writing {} ...".format(opath))
t0 = time.time()
doc = pd.ExcelWriter(opath, engine="odf")
df.to_excel(doc, sheet_name="漲Sheet1碁")
doc.close()
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print("start: {}".format(t_start))
print("takes: {:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )

sys.exit(0)

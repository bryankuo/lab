#!/usr/bin/python

# python3 rw_qvrs.py [yyyymmdd]
#
# \param in  qvrs.yyyymmdd.ticker.asc.csv, from qvrs.sh
# \param out pandas df
#
# reading csv, assume post running "qvrs.sh", generate rs in percentile rank
# on daily bases
#
# return 0

import sys, os, time
import pandas as pd
from pprint import pprint
from datetime import datetime
import numpy as np

DIR0r = "./datafiles/taiex/rs"
DIR0a = "./datafiles/taiex/after.market"

yyyymmdd = sys.argv[1]
ipath = os.path.join(DIR0r, "qvrs." + yyyymmdd + '.ticker.asc.csv')
print("reading {} ...".format(ipath))

t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
df = pd.read_csv(ipath, sep=':', skiprows=0, header=0)
# pprint(df)
# print(df.dtypes)

# df = df.convert_objects(convert_numeric=True)
# "--" inside
# df['rs'] = df['rs'].str.replace('%','').astype(np.float64)
# NaN
# df['rs'] = pd.to_numeric(df['rs'].str.replace('%',''), errors='coerce')
# print(df.dtypes)
# print(df.iloc[1]['rs'])
df['rs'] = df['rs'].rank(ascending=True, pct=True)
df.loc[:,'rs'] *= 100
# pprint(df)
print(df.shape)

opath = os.path.join(DIR0r, "qvrs." + yyyymmdd + '.ticker.asc.ods')
print("writing {}".format(opath))
t0 = time.time()
doc = pd.ExcelWriter(opath, engine="odf")
df.to_excel(doc, sheet_name="yyyymmdd")
doc.close()
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print("start: {}".format(t_start))
print("takes: {:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )

sys.exit(0)

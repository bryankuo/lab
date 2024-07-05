#!/usr/bin/python3

# plot number of tick in terms of amplitude
#
# @see https://stackoverflow.com/a/21519229

import sys, os
import matplotlib.pyplot as plt
from pprint import pprint
from datetime import datetime
import pandas as pd
# @see https://stackoverflow.com/a/477635
import numpy as np

DIR0="./datafiles/taiex/after.market"

def parse_df(day):
    cname = day + ".all.columns.csv"
    c_path = os.path.join(DIR0, cname)
    df = pd.read_csv(c_path, sep=':', skiprows=0, header=0)
    # print("read {} {}".format(c_path, \
    #    datetime.today().strftime('%H:%M:%S.%f')[:-3]))
    return df

day = sys.argv[1]
df = parse_df(day)
# print(df.info())
# @see https://stackoverflow.com/a/47891276
df['振幅'] = df['振幅'].str.rstrip('%').astype('float')
volume_threshold = 10000
# df_mask = df[df["振幅"] > volume_threshold]
# pprint(df[['代號', '振幅']])
# print("max {} min {}".format(df['振幅'].max(),df['振幅'].min()))
a_max = df['振幅'].max()
# print(len( df[ 3.0 < df["振幅"] ]))
tk = 0.5
l = np.arange(0, a_max, tk)
# print(l)
counts = []
for i in l:
    counts.append(len( df[ (i <= df["振幅"]) & (df.振幅 < i+tk) ] ))
# pprint(counts)
li = list(zip(l, counts))
#pprint(li)

x, y = zip(*li)
plt.scatter(*zip(*li))
plt.show()

sys.exit(0)

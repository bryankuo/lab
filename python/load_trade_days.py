#!/usr/bin/env python3

#
# python3 load_trade_days.py [d0 d1 ...]
# list tickers where
# 1. volume greater than 10k lots and
# 2. touch 10d low today
#
# \param in  yyyymmdd in descending order

import sys, os
from datetime import datetime
import pandas as pd
from pprint import pprint

DIR0="./datafiles/taiex/after.market"

def parse_df(day):
    cname = day + ".all.columns.csv"
    c_path = os.path.join(DIR0, cname)
    df = pd.read_csv(c_path, sep=':', skiprows=0, header=0)
    # print("read {} {}".format(c_path, \
    #    datetime.today().strftime('%H:%M:%S.%f')[:-3]))
    return df

dfs = []
trade_days = sys.argv[1:]
for day in trade_days:
    # print("{}".format(day))
    df = parse_df(day)
    dfs.append(df)

# tkrs = dfs[0]['代號'].tolist() # all
volume_threshold = 10000
df_mask = dfs[0][dfs[0]["成交量"] > volume_threshold]
tkrs = df_mask['代號'].tolist()

today_10d_lows = []

for tkr in tkrs:
    lows = []
    for df in dfs:
        mask = df["代號"] == tkr
        lows.append(df.loc[mask, '最低'].squeeze())
    val, idx = min((val, idx) for (idx, val) in enumerate(lows))
    # print("v {} i {} date {}".format(val, idx, sys.argv[1+idx]))
    if ( idx == 0 ):
        today_10d_lows.append(tkr)
# print(today_10d_lows)
print("# touch {} days low and v > {} on {}: {} \n{}" \
    .format(len(trade_days), volume_threshold, trade_days[0], \
    len(today_10d_lows), today_10d_lows))

# today_10d_lows = list(set(today_10d_lows)) # distinction

sys.exit(0)

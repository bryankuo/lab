#!/usr/bin/python

# ./ndays_2new_high.sh 2330 2>&1 | tee ./2330.csv
# python3 peak_valley.py [ticker]

import sys, os, time
import pandas as pd
from pprint import pprint
# 1. from scipy.signal import find_peaks # OK
# 2. from libs import detect_peaks # @see from libs import detect_peaks
# 3. @see https://shorturl.at/77YuU

tkr = sys.argv[1]
f1 = tkr + ".csv"
ipath1 = os.path.join("./", f1)
df = pd.read_csv(ipath1, sep=':', skiprows=0, header=0)
# pprint(df)
print("{}".format(df.shape[0])) # len(df))), number of row

peaks = []
valleys = []
# df.reindex(index=df.index[::-1])
# for index, row in df.iloc[::-1].iterrows(): # reverse index OK
for index, row in df.iterrows():
    t_day = int(row['trade date'])
    close = row['close']
    high  = row['high']
    low   = row['low']
    if index == 0 :
        next_day = df.iloc[index + 1]
        if   high > next_day['close']:
            p_tuple = []; p_tuple.append(t_day); p_tuple.append(high)
            peaks.append(p_tuple)
        elif low  < next_day['close']:
            v_tuple = []; v_tuple.append(t_day); v_tuple.append(low)
            valleys.append(v_tuple)
    elif index == df.shape[0]-1 :
        prev_day = df.iloc[index - 1] # ['word']
        if  high > prev_day['high'] :
            p_tuple = []; p_tuple.append(t_day); p_tuple.append(high)
            peaks.append(p_tuple)
        elif low < prev_day['low'] :
            v_tuple = []; v_tuple.append(t_day); v_tuple.append(low)
            valleys.append(v_tuple)
    else:
        prev_day = df.iloc[index - 1]
        next_day = df.iloc[index + 1]
        if  high > prev_day['high'] and high > next_day['close']:
            p_tuple = []; p_tuple.append(t_day); p_tuple.append(high)
            peaks.append(p_tuple)
        elif low < prev_day['low']  and low  < next_day['close']:
            v_tuple = []; v_tuple.append(t_day); v_tuple.append(low)
            valleys.append(v_tuple)
    # print("At index {}, the close is {}, ndays {}, lh {}" \
    #    .format(index, row['close'], ndays, last_high))
print("Peaks:")
pprint("{}".format(peaks))
print("Valleys:")
pprint("{}".format(peaks))

sys.exit(0)

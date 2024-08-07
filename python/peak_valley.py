#!/usr/bin/python

# ./ndays_2new_high.sh 2330 2>&1 | tee ./2330.csv
# python3 peak_valley.py [ticker]
# python3 peak_valley.py 2330 > pv.2330.txt

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
print("# days {}".format(df.shape[0])) # len(df))), number of row

peaks = []; ndays = 0; days_2peak = []
valleys = []; ndays0 = 0; days_2valley = []
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
            peaks.append(p_tuple); days_2peak.append(ndays); ndays = 0
        elif low  < next_day['close']:
            v_tuple = []; v_tuple.append(t_day); v_tuple.append(low)
            valleys.append(v_tuple); days_2valley.append(ndays0); ndays0 = 0

    elif index == df.shape[0]-1 :
        prev_day = df.iloc[index - 1] # ['word']
        if  high > prev_day['high'] :
            p_tuple = []; p_tuple.append(t_day); p_tuple.append(high)
            peaks.append(p_tuple); days_2peak.append(ndays); ndays = 0
        elif low < prev_day['low'] :
            v_tuple = []; v_tuple.append(t_day); v_tuple.append(low)
            valleys.append(v_tuple); days_2valley.append(ndays0); ndays0 = 0
    else:
        prev_day = df.iloc[index - 1]
        next_day = df.iloc[index + 1]
        if  high > prev_day['high'] and high > next_day['close']:
            p_tuple = []; p_tuple.append(t_day); p_tuple.append(high)
            peaks.append(p_tuple); days_2peak.append(ndays); ndays = 0
        elif low < prev_day['low']  and low  < next_day['close']:
            v_tuple = []; v_tuple.append(t_day); v_tuple.append(low)
            valleys.append(v_tuple); days_2valley.append(ndays0); ndays0 = 0

    ndays += 1; ndays0 += 1
    # print("At index {}, the close is {}, ndays {}, lh {}" \
    #    .format(index, row['close'], ndays, last_high))
# print("Peaks:")
# pprint("{}".format(peaks))
window = 10
print("last {} of # days to peak:".format(window))

pprint("{}".format(days_2peak[-window:]))
avg_peak_day = float( sum(days_2peak[-window:]) / len(days_2peak[-window:]) )
print("avg of last {} of # days to peak: {:.2f}" \
    .format( window, avg_peak_day ))


# print("Valleys:")
# pprint("{}".format(peaks))
print("last 10 of # days to valley:")
pprint("{}".format(days_2valley[-10:]))
avg_valley_day = float( sum(days_2valley[-10:]) / len(days_2valley[-10:]) )
print("avg of last {} of # days to valley: {:.2f}" \
    .format( window, avg_valley_day ))
pv_ratio = float ( avg_peak_day / avg_valley_day )
print("peak/valley ratio {:.2f}, smaller tends more peak".format(pv_ratio))
print("if close to 1, tends choppy")
sys.exit(0)

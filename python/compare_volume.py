#!/usr/bin/python3

# python3 compare_volume.py [dt1] [dt0]
# \param in dt1 yyyymmdd
# \param in dt0 yyyymmdd, last day
# \param out 3 column csv file
# return 0

# @see https://tinyurl.com/y8442u6u
# Volume Ratio Index
# volume is the leading indicator of stock prices
# @see https://tinyurl.com/2cau7m5j

import os, sys, time
from pprint import pprint
from datetime import datetime

# PyUNO @see uno_kicks.py
# import uno
# from com.sun.star.uno import RuntimeException
# for i in sys.path:
#      print(i)

# How to retrieve a module's path? @see https://stackoverflow.com/a/248862
# path = os.path.abspath(uno.__file__)
# print(path)

# sys.path.append(os.getcwd())
# sys.path.append("/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages/")
# import numpy
# print(numpy.__file__) # 1.21.1

import pandas as pd
# v = pd.__version__ # 1.3.1
# print(pd.__version__)
# // TODO: using pandas inthe libreoffice python installation

if ( len(sys.argv) < 2 ):
    print("python3 compare_volume.py [dt1] [dt0]")
    sys.exit(0)

dt1 = sys.argv[1]
dt0 = sys.argv[2]

DIR0="./datafiles/taiex/after.market"

fname1 = dt1 + ".csv"
path1  = os.path.join(DIR0, fname1)

fname0 = dt0 + ".csv"
path0  = os.path.join(DIR0, fname0)

ofname = dt1 + ".vr.csv"
opath  = os.path.join(DIR0, ofname)

print("comparing: ")
print(path1 + " to")
print(path0)

f1 = open(path1)
f0 = open(path0)

# reader=csv.reader(f1, delimiter=':') #
# df1=list(reader)

df1a = pd.read_csv(path1, sep=':', header=None)
df0a = pd.read_csv(path0, sep=':', header=None)
if ( len(df1a) != len(df0a) ):
    print("size is different, {:>4} and {:>4}".format(len(df1a), len(df0a)))
# df1.sort_index(inplace=True)
# df1=df1.sort_index()
df1=df1a.sort_values(0).copy()
df0=df0a.sort_values(0, ascending=True).copy()
# df0.sort_values(0, inplace=True)

tkr1 = df1[0].tolist()
tkr2 = df0[0].tolist()
tkr1_only = []; tkr2_only = []
if ( tkr1 != tkr2 ):
    tkr1_only = list(set(tkr1) - set(tkr2))
    tkr2_only = list(set(tkr2) - set(tkr1))
    print("list is different:")
    print("tkr1 - tkr2: "+str(len(tkr1_only)))
    pprint( tkr1_only )
    print("tkr2 - tkr1: "+str(len(tkr2_only)))
    pprint( tkr2_only )

# t0 = time.time_ns() / (10 ** 9)
# t0 = time.time_ns()
t0 = time.time()
# @see https://stackoverflow.com/a/18406412
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]

try:
    ratio = []
    i2_start = 0
    for i1 in range(0, len(df1)):
        found = False
        for i2 in range(i2_start, len(df0)):
            if ( df1[0][i1] == df0[0][i2] ):
                found = True
                break
            elif ( df1[0][i1] < df0[0][i2] ):
                print( "{:>4d}".format(i1) + " " + str(df1[0][i1]) \
                    + " " + str(df1[3][i1]) + " " + str(df0[3][i2]) )
                found = False
                break
            # else:
            #    continue

        if ( found ):
            # ternary op @see https://stackoverflow.com/a/394814
            r = [ "{:>04d}".format(int(df1[0][i1])) , \
                float(df1[3][i1])/ float(df0[3][i2]) if ( df0[3][i2] != 0 ) else 1, \
                df1[3][i1], \
                df0[3][i2] ]
            ratio.append(r)
            i2_start += 1
        else:
            r = [ "{:>04d}".format(int(df1[0][i1])) , \
                "n/a", \
                df1[3][i1], \
                "n/a" ]
            ratio.append(r)

    df3 = pd \
        .DataFrame(ratio, columns=['ticker', 'ratio', 'volume', 'last'])
    df3 = df3.sort_values("ticker")
    # pprint(df3)
    # df3.to_csv(opath)
    df3.to_csv(opath, sep = ':',header=True, index=False)

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    # pass
    f1.close(); f0.close()

# t1 = time.time_ns()
# print("{:>.0f} nanoseconds".format(t1-t0))
# print("{:,} nanoseconds".format(t1-t0))
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print( "time {:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )
print("ouput: " + opath)
sys.exit(0)

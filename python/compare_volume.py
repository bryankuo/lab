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

ofname = dt1 + ".vr.csv"
opath  = os.path.join(DIR0, ofname)

path1  = os.path.join(DIR0, dt1+".all.columns.csv")
df1 = pd.read_csv(path1, sep=':', skiprows=0, header=0)
print("-loading {} {}".format(df1.shape, path1))

path0  = os.path.join(DIR0, dt0+".all.columns.csv")
df0 = pd.read_csv(path0, sep=':', skiprows=0, header=0)
print("-loading {} {}".format(df0.shape, path0))

print("comparing: ")
print(path1 + " to")
print(path0)

df1.sort_values('代號', ascending=[True], inplace=True)
df1 = df1.reset_index()  # make sure indexes pair with number of rows
df0.sort_values('代號', ascending=[True], inplace=True)
df0 = df0.reset_index()

# t0 = time.time_ns() / (10 ** 9)
# t0 = time.time_ns()
t0 = time.time()
# @see https://stackoverflow.com/a/18406412
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]

try:
    ratio = []
    i0_start = 0
    # // FIXME: use others instead of iteration
    # @see https://stackoverflow.com/a/55557758
    for i1 in range(0, df1.shape[0]):
        # print("{}".format(df1.loc[[i1]]))
        found = False
        for i0 in range(i0_start, df0.shape[0]):
            tk1 = df1.at[i1, "代號"]
            tk0 = df0.at[i0, "代號"]
            if ( i1 % 300 == 0 ):
                print("i1 {:>4} tk1 {:>4} tk0 {:>4}".format(i1, tk1, tk0))
            if ( tk1 == tk0 ):
                found = True
                break
            elif ( tk1 < tk0 ):
                found = False
                break
        tk1 = df1.at[i1, "代號"]
        v1  = df1.at[i1, "成交量"]
        if ( found ):
            # ternary op @see https://stackoverflow.com/a/394814
            v0  = df0.at[i0, "成交量"]
            r = [ "{:>04d}".format(tk1) , \
                float(v1)/float(v0) if ( v0 != 0 ) else 1, v1, v0 ]
            i0_start += 1
        else:
            r = [ "{:>04d}".format(tk1) , "n/a", v1, "n/a" ]
        ratio.append(r)

    df3 = pd \
        .DataFrame(ratio, columns=['ticker', 'ratio', 'volume', 'last'])
    df3 = df3.sort_values("ticker")
    # print(df3.dtypes)
    df3.to_csv(opath, sep = ':',header=True, index=False)
    # pprint(df3)

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass

# t1 = time.time_ns()
# print("{:>.0f} nanoseconds".format(t1-t0))
# print("{:,} nanoseconds".format(t1-t0))
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print( "time {:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )
print("ouput: " + opath)
sys.exit(0)

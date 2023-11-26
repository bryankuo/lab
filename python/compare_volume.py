#!/usr/bin/python3

# python3 compare_volume.py [dt1] [dt2]
# \param in dt1 yyyymmdd
# \param in dt2 yyyymmdd
# return 0

import os, sys, pandas as pd, time
from pprint import pprint

if ( len(sys.argv) < 2 ):
    print("python3 compare_volume.py [dt1] [dt2]")
    sys.exit(0)

dt1 = sys.argv[1]
dt2 = sys.argv[2]

DIR0="./datafiles/taiex/after.market"

fname1 = dt1 + ".csv"
path1  = os.path.join(DIR0, fname1)

fname2 = dt2 + ".csv"
path2  = os.path.join(DIR0, fname2)
print("comparing: " + path1 + " " + path2)
f1 = open(path1)
f2 = open(path2)

# reader=csv.reader(f1, delimiter=':') #
# df1=list(reader)

df1a = pd.read_csv(path1, sep=':', header=None)
df2a = pd.read_csv(path2, sep=':', header=None)
if ( len(df1a) != len(df2a) ):
    print("size is different,")
    sys.exit(0)

# df1.sort_index(inplace=True)
# df1=df1.sort_index()
df1=df1a.sort_values(0).copy()
# pprint(df1)

df2=df2a.sort_values(0, ascending=True).copy()
# df2.sort_values(0, inplace=True)

tkr1 = df1[0].tolist()
tkr2 = df2[0].tolist()
if ( tkr1 != tkr2 ):
    print("list is different,")
    sys.exit(0)

print("size: " + str(len(df1)))
# t0 = time.time_ns() / (10 ** 9)
t0 = time.time_ns()

try:
    ratio = []
    for i in range(0, len(df1)):
        # print( "{:>4d}".format(i) + " " + str(df1[0][i]) \
        #    + " " + str(df1[3][i]) + " " + str(df2[3][i]) )
        r = [ int(df1[0][i]) , \
            float(df1[3][i])/ float(df2[3][i]) if ( df2[3][i] != 0 ) else 1 ]
        # @see https://stackoverflow.com/a/394814
        ratio.append(r)
    df3 = pd.DataFrame(ratio, columns=['ticker', 'ratio'])
    # pprint(df3)

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass

t1 = time.time_ns()
# print("{:>.0f} nanoseconds".format(t1-t0))
print("{:,} nanoseconds".format(t1-t0))

sys.exit(0)

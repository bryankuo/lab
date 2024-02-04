#!/usr/bin/python

# python3 wrangle_df.py [dt1] [dt0]
#
# \param in  qvrs.dt1.ticker.asc.csv
# \param in  qvrs.dt0.ticker.asc.csv
# \param out pandas df
#
# compare 2 dfs
#
# return 0

import sys, os, time
import pandas as pd
from pprint import pprint
from datetime import datetime
import numpy as np

DIR0r = "./datafiles/taiex/rs"

if ( len(sys.argv) < 3 ):
    print("usage: wrangle_df.py [dt1] [dt0]")
    sys.exit(0)

dt1 = sys.argv[1]
dt0 = sys.argv[2]

ipath1 = os.path.join(DIR0r, "qvrs." + dt1 + '.ticker.asc.ods')
# df1 = pd.read_csv(ipath1, sep=':', skiprows=0, header=0)
ipath0 = os.path.join(DIR0r, "qvrs." + dt0 + '.ticker.asc.ods')

try:
    df1 = pd.read_excel(ipath1, engine='odf')
    print("reading {} ... {} ".format(ipath1, df1.shape))

    df0 = pd.read_excel(ipath0, engine='odf')
    print("reading {} ... {} ".format(ipath0, df0.shape))

    # pprint(df)
    # print(df.dtypes)

    # df = df.convert_objects(convert_numeric=True)
    # "--" inside
    # df['rs'] = df['rs'].str.replace('%','').astype(np.float64)
    # NaN
    # df['rs'] = pd.to_numeric(df['rs'].str.replace('%',''), errors='coerce')
    # print(df.dtypes)
    # print(df.iloc[1]['rs'])
    # df['rs'] = df['rs'].rank(ascending=False, pct=True)
    # df.loc[:,'rs'] *= 100
    #pprint(df)

    # df1.set_index('代號', inplace=True)
    # df1 = df1.reset_index(drop=True)
    # df0 = df0.reset_index(drop=True)
    # l1 = df1.columns
    # l0 = df0.columns
    # print("l1 {}".format(l1))
    # print("l0 {}".format(l0))
    # df0.set_index('代號', inplace=True)

    #
    # df3 = pd.concat([df1, df0])
    # print("union concat df3 shape {}".format(df3.shape))

    # Pandas Merging 101 @see https://stackoverflow.com/q/53645882
    #
    # df3 = pd.merge(df1, df0, on='代號', how='outer')
    # print("join merge df3 shape {}".format(df3.shape))

    # df3 = df1.merge(df0, on='代號', how='left')
    # print("join merge df3 shape {}".format(df3.shape))
    # cols_to_use = df1.columns.difference(df0.columns)

    # @see books https://wesmckinney.com/book/data-wrangling
    # df3 = df1.join(df0, on='代號')

    #drop all columns except points and blocks
    df1a = df1[['代號']]
    df0a = df0[['代號']] # .drop('代號', axis=1)
    df3 = df1a.merge(df0a, on='代號', how='outer')
    df3.sort_values("代號", inplace=True)

    t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
    t0 = time.time()
    #doc = pd.ExcelWriter(opath, engine="odf")
    # df.to_excel(doc, sheet_name="dt1")
    # doc.close()

    # compare dataframes
    # diff = df1.compare(df0)
    # print differences

    # print(df1.equals(df0)) # works

    # @see https://stackoverflow.com/a/51039065
    # df0 = df0.set_index('代號')
    # df1 = df1.set_index('代號').reindex(df0.index)
    # df3 = df1 != df0
    # print (df3)

    t1 = time.time()
    hours, rem = divmod(t1-t0, 3600)
    minutes, seconds = divmod(rem, 60)
    print("start: {}".format(t_start))
    print("takes: {:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )

    print(df3.shape); print('')

    print(df3); print('')

    # print(cols_to_use); print('')

except ValueError:
    # can only compare identically-labeled , ie. same shape, identical row,
    # columns
    # // TODO:
    raise

except FileNotFoundError:
    raise

finally:
    pass
sys.exit(0)

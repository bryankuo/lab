#!/usr/bin/python3

# python3 compare_volume.py [today] [last day]
# \param in dt1 today, yyyymmdd
# \param in dt2 last day, yyyymmdd
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

# import pandas as pd
# v = pd.__version__ # 1.3.1
# print(pd.__version__)
# // TODO: using pandas inthe libreoffice python installation

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
try:
    ratio = []
    for i in range(0, 10): # len(df1)):
        # print( "{:>4d}".format(i) + " " + str(df1[0][i]) \
        #    + " " + str(df1[3][i]) + " " + str(df2[3][i]) )
        r = [ int(df1[0][i]) , \
            float(df1[3][i])/ float(df2[3][i]) if ( df2[3][i] != 0 ) else 1, \
            ]
        # @see https://stackoverflow.com/a/394814
        ratio.append(r)
    df3 = pd.DataFrame(ratio, columns=['ticker', 'ratio', 'last', 'volume'])
    # pprint(df3)

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass


print("updating calc...")


sheet_name = "20220126"
localContext = uno.getComponentContext()
resolver = localContext.ServiceManager\
    .createInstanceWithContext( \
        "com.sun.star.bridge.UnoUrlResolver", localContext )
ctx = resolver.resolve(
    "uno:socket,host=localhost,port=2002;urp;StarOffice.ComponentContext" )
smgr = ctx.ServiceManager
desktop = smgr.createInstanceWithContext( "com.sun.star.frame.Desktop",ctx)
model = desktop.getCurrentComponent()
active_sheet = model.Sheets.getByName(sheet_name)
doc = None
numbers = None
locale = None
nl = None
while doc is None:
    doc = desktop.getCurrentComponent()
    numbers = doc.NumberFormats
    locale = doc.CharLocale
try:
    nl = numbers.addNew( "###0.000",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0.000", locale, False)

guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
n_ticker = len(cursor.Rows) - 1

columns = active_sheet.getColumns()
columns.getByName("C:BG")
columns.IsVisible = False

# t0 = time.time_ns() / (10 ** 9)
# t0 = time.time_ns()
t0 = time.time()
# @see https://stackoverflow.com/a/18406412
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]

for i in range(2, cursor.Rows):
    tkr = active_sheet.getCellRangeByName("$A"+str(i)).String
    print(tkr)
    # active_sheet.getCellRangeByName(

# t1 = time.time_ns()
# print("{:>.0f} nanoseconds".format(t1-t0))
# print("{:,} nanoseconds".format(t1-t0))
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print( "{:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )

sys.exit(0)

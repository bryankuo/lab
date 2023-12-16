#!/usr/bin/python3

# python3 uno_vratio.py [today] [last day]
# \param in dt1 today, yyyymmdd
# \param in dt2 last day, yyyymmdd
# return 0

# @see https://tinyurl.com/y8442u6u
# Volume Ratio Index
# volume is the leading indicator of stock prices
# @see https://tinyurl.com/2cau7m5j

import os, sys, time, csv
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

# import pandas as pd # // FIXME:
# v = pd.__version__ # 1.3.1
# print(pd.__version__)
# // TODO: using pandas inthe libreoffice python installation

import uno
from com.sun.star.uno import RuntimeException

if ( len(sys.argv) < 2 ):
    print("python3 uno_vratio.py [dt1] [dt2]")
    sys.exit(0)

dt1 = sys.argv[1]
dt2 = sys.argv[2]

DIR0="./datafiles/taiex/after.market"

ifname1 = dt1 + ".vr.csv"
ipath1  = os.path.join(DIR0, ifname1)
print("update calc loading: " + ipath1)
f1 = open(ipath1)

data = list(csv.reader(f1, delimiter=':')) # list from 2d csv
# print(data[0])
# print(data[1][4])

# df1 = pd.read_csv(path1, sep=':', header=['ticker', 'ratio', 'last', 'volume'])
# df2a = pd.read_csv(path2, sep=':', header=None)

# df1=df1a.sort_values(0).copy()
# print("size: " + str(len(df1)))
# pprint(df1)

localContext = uno.getComponentContext()
resolver = localContext.ServiceManager\
    .createInstanceWithContext( \
        "com.sun.star.bridge.UnoUrlResolver", localContext )
ctx = resolver.resolve(
    "uno:socket,host=localhost,port=2002;urp;StarOffice.ComponentContext" )
smgr = ctx.ServiceManager
desktop = smgr.createInstanceWithContext( "com.sun.star.frame.Desktop",ctx)
# model = desktop.getCurrentComponent()

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

# sheet_name = "20231211"
sheet_name = "20231211"
active_sheet = doc.Sheets.getByName(sheet_name)

guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
n_ticker = len(cursor.Rows) - 1

VR="BI"
VOL="BJ"
LAST="BK"
UPTD = "$BH"

# t0 = time.time_ns() / (10 ** 9)
# t0 = time.time_ns()
t0 = time.time()
# @see https://stackoverflow.com/a/18406412
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]

try:
    columns = active_sheet.getColumns()
    # columns.IsVisible = False # all hide

    # @see http://surl.li/nottj
    the_range = active_sheet.getCellRangeByName("C:BG")
    the_range.Columns.IsVisible = False
    i = 1
    active_sheet.getCellRangeByName(  VR+str(i)).String = "V. ratio"
    active_sheet.getCellRangeByName(  VR+str(i)).NumberFormat = nl
    active_sheet.getCellRangeByName( VOL+str(i)).String = "Volume"
    active_sheet.getCellRangeByName(LAST+str(i)).String = "Last V."

    tkrs = [ x[0] for x in data ]
    rtos = [ x[1] for x in data ]
    vol  = [ x[2] for x in data ]
    last = [ x[3] for x in data ]
    checked  = [ 0 ] * len(tkrs)
    # // FIXME: should be # of rows sheet
    # // FIXME: or if

    start0 = 2; start1 = 0; missed = 0
    for i in range(start0, len(cursor.Rows)+1):
        tkr = active_sheet.getCellRangeByName("$A"+str(i)).String
        found = False
        for j in range(start1, len(tkrs)):
            # print("i {:0>4} j {:0>4} tkr {:0>4}".format(i, j, tkr))
            if ( checked[j] == 0 and tkrs[j] == tkr ):
                found = True
                break
        if ( found ):
            print("i {:0>4} j {:0>4} tkr {:0>4} found" \
                .format(i, j, tkr))
            cell = active_sheet.getCellRangeByName(VR+str(i))
            cell.NumberFormat = nl
            if ( rtos[j] != "n/a" ):
                cell.Value = rtos[j]
            else:
                cell.String = rtos[j]
            active_sheet.getCellRangeByName(VOL+str(i)).Value  = vol[j]
            cell = active_sheet.getCellRangeByName(LAST+str(i))
            if ( last[j] != "n/a" ):
                cell.Value = last[j]
            else:
                cell.String = last[j]
            cell = active_sheet.getCellRangeByName(UPTD + str(i))
            cell.String = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
            checked[j] = 1; start0 = i + 1; start1 = j + 1
        else:
            print("i {:0>4} j {:0>4} tkr {:0>4} not found in {}" \
                .format(i, j, tkr, ipath1))
            # // FIXME: some in list but not found in spreadsheet -> add one row
            # // FIXME: at the end, sort sheet then save
            missed += 1

    # // FIXME: possible new in data, therefore search
    print("# file {:>4}, {:>4} missed, ".format(len(tkrs)-1, missed)) # // FIXME:

    the_range = active_sheet.getCellRangeByName("BI:BL")
    the_range.Columns.OptimalWidth = True

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass

doc.store()

f1.close()
# t1 = time.time_ns()
# print("{:>.0f} nanoseconds".format(t1-t0))
# print("{:,} nanoseconds".format(t1-t0))
t1 = time.time()
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
print("start: " + t_start)
print( "{:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds) )

sys.exit(0)

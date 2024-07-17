#!/usr/bin/python3

'''
/Applications/LibreOffice.app/Contents/Resources/python \
    ./uno/load/lnglat.py
'''

# ./uno_launch.sh datafiles/activity_watchlist.ods


# load etf id into calc column
#
# \param in ./datafiles/taiex/etf_components/
# return 0

# @see https://tinyurl.com/y8442u6u
# Volume Ratio Index
# volume is the leading indicator of stock prices
# @see https://tinyurl.com/2cau7m5j

import os, sys, time, csv
# import pandas as pd # // FIXME:
from pprint import pprint
from datetime import datetime

import uno
from com.sun.star.uno import RuntimeException

DIR0 = "./datafiles/taiex"
ifname1 = 'companies.kml.csv'
ipath1  = os.path.join(DIR0, ifname1)
print("update calc loading: " + ipath1)
f1 = open(ipath1)
components = list(csv.reader(f1, delimiter=':'))
# print(components[len(components)-1])

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

sheet_name = "20231211"
sheet0 = doc.Sheets.getByName(sheet_name)

guessRange = sheet0.getCellRangeByPosition(0, 2, 0, 3000)
cursor = sheet0.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = sheet0.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
n_ticker = len(cursor.Rows) - 1

# t0 = time.time_ns() / (10 ** 9)
# t0 = time.time_ns()
t0 = time.time()
# @see https://stackoverflow.com/a/18406412
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]

try:
    columns = sheet0.getColumns()
    hide_lst = ["A:$AMJ"]
    for r in hide_lst:
        the_range = sheet0.getCellRangeByName(r)
        doc.CurrentController.select(the_range)
        the_range.Columns.IsVisible = False
    # make it clean, visually
    opt_lst = ["A:B", "CU:CV"] #; print(opt_lst)
    for r in opt_lst:
        the_range = sheet0.getCellRangeByName(r)
        doc.CurrentController.select(the_range)
        the_range.Columns.OptimalWidth = True

    tkrs       = [ x[0] for x in components ]
    longitudes = [ x[1] for x in components ]
    latitudes  = [ x[2] for x in components ]
    checked  = [ 0 ] * len(tkrs)

    # brute force for 50 items, components list not sorted
    start0 = 2; start1 = 0; missed = 0
    for i in range(start0, len(cursor.Rows)+1):
        tkr = sheet0.getCellRangeByName("$A"+str(i)).String
        found = False
        for j in range(start1, len(tkrs)):
            if ( checked[j] == 0 and tkrs[j] == tkr ):
                found = True
                break
        if ( found ):
            print("i {:0>4} j {:0>4} tkr {:0>4} update" \
                .format(i, j, tkr))
            cell = sheet0.getCellRangeByName("$B" + str(i))
            cell.CellBackColor = 0xFFFF00
            sheet0.getCellRangeByName( "$CU" + str(i)).Value \
                = float(longitudes[j])
            sheet0.getCellRangeByName( "$CV" + str(i)).Value \
                = float(latitudes[j])
            cell = sheet0.getCellRangeByName("$BH" + str(i))
            cell.String = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
            checked[j] = 1
            start0 = i + 1; start1 = 0
        else:
            # print("i {:0>4} j {:0>4} tkr {:0>4} type 5 not found in {}" \
            #     .format(i, j, tkr, ipath1))
            # // FIXME: some in list but not found in spreadsheet -> add one row
            # // FIXME: at the end, sort sheet then save
            missed += 1

    # // FIXME: possible new in data, therefore search
    print("# file {:>4} in {}".format(len(tkrs), ipath1))
    print(len(columns))

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

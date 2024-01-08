#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_qvrs.py [yyyymmdd]
#

import uno, sys, time, os, csv
from datetime import datetime
from com.sun.star.uno import RuntimeException

yyyymmdd = sys.argv[1]
DIR0="./datafiles/taiex/rs"

sheet_name = "20231211"

# get the uno component context from the PyUNO runtime
localContext = uno.getComponentContext()

# create the UnoUrlResolver
resolver = localContext.ServiceManager\
    .createInstanceWithContext( \
        "com.sun.star.bridge.UnoUrlResolver", localContext )

# connect to the running office
ctx = resolver.resolve(
    "uno:socket,host=localhost,port=2002;urp;StarOffice.ComponentContext" )
smgr = ctx.ServiceManager

# get the central desktop object
desktop = smgr.createInstanceWithContext( "com.sun.star.frame.Desktop",ctx)
# @see https://www.openoffice.org/api/docs/common/ref/com/sun/star/sheet/module-ix.html
# access the current writer document

# desktop = XSCRIPTCONTEXT.getDesktop() # not defined # using in test.py?
# doc = XSCRIPTCONTEXT.getDocument()

doc = None
numbers = None
locale = None
nl = None
while doc is None:
    doc = desktop.getCurrentComponent()
    numbers = doc.NumberFormats # // FIXME: only when get focused, or touched
    locale = doc.CharLocale

# instead of
# @see https://ask.libreoffice.org/t/formatting-data-cell-from-macro-in-calc/23740
try:
    nl = numbers.addNew( "###0.00",  locale )
    # nl1 = numbers.addNew( "###0",  locale )
    # nl2 = numbers.addNew( "###0.000",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0.00", locale, False)
    # nl1 = numbers.queryKey("###0", locale, False)
    # nl2 = numbers.addNew( "###0.000",  locale )

sheet0 = doc.Sheets.getByName(sheet_name)

columns = ["C:F", "K:BC", "$BE1", "BF:BH", "BL:BW"]
for cols in columns:
    # print(cols)
    the_range = sheet0.getCellRangeByName(cols)
    doc.CurrentController.select(the_range)
    the_range.Columns.IsVisible = False

path0 = os.path.join(DIR0, "qvrs."+yyyymmdd+".ticker.asc.csv")
inf0 = open(path0, 'r')
data = list(csv.reader(inf0, delimiter=':'))
tkrs = [ x[0] for x in data ]
quot = [ x[1] for x in data ]
vols = [ x[2] for x in data ]
rs   = [ x[3] for x in data ]
checked  = [ 0 ] * len(tkrs)

# assume no more than 3000 listed.
guessRange = sheet0.getCellRangeByPosition(0, 1, 3, 3001)
cursor = sheet0.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = sheet0.getCellRangeByPosition(0, 1, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)
n_ticker = ( last_row - 2 ) + 1
print("# ticker {}".format(n_ticker))

sheet0.getCellRangeByName("$BJ1").String = "Vdt1.(" + yyyymmdd + ")"
sheet0.getCellRangeByName("$BX1").String = "RS IntraDay"

start0 = 2; start1 = 1; missed = 0
for i in range(start0, len(cursor.Rows)+1):
    tkr = sheet0.getCellRangeByName("$A"+str(i)).String
    found = False
    for j in range(start1, len(tkrs)):
        # print("i {:0>4} j {:0>4} tkr {:0>4}".format(i, j, tkr))
        if ( checked[j] == 0 and tkrs[j] == tkr ):
            found = True
            break
    if ( found ):
        cell = sheet0.getCellRangeByName("$J"+str(i))
        cell.NumberFormat = nl
        cell.Value = float(quot[j])
        cell = sheet0.getCellRangeByName("$BJ"+str(i))
        cell.NumberFormat = nl
        cell.Value = float(vols[j])
        cell = sheet0.getCellRangeByName("$BX"+str(i))
        if ( rs[j] != "n/a" ):
            cell.NumberFormat = nl
            cell.Value = float(rs[j])
        else:
            cell.String = rs[j]
        sheet0.getCellRangeByName("$BH"+str(i)).String \
            = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
        checked[j] = 1; start0 = i + 1; start1 = j + 1
    else:
        print("i {:0>4} j {:0>4} tkr {:0>4} not found in {}" \
            .format(i, j, tkr, path0))
        # // FIXME: some in list but not found in spreadsheet -> add one row
        # // FIXME: seems type 5 ticker
        missed += 1

columns = ["A:B", "G:J", "BD1", "BF1", "BI:BK", "BX1"]
for cols in columns:
    the_range = sheet0.getCellRangeByName("BM1")
    doc.CurrentController.select(the_range)
    the_range.Columns.IsVisible = True
    the_range.Columns.OptimalWidth = True

doc.store()
print("uno_qvrs.py-")
sys.exit(0)

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

columns = ["C:F", "K:BC", "$BE1", "BG:BH", "BL:BW"]
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

idx = 0
for tkr in tkrs:
    if ( 1 <= idx ):
        # print("{} {}".format(idx, tkr))
        ColA = sheet0.getCellRangeByName("A1:A3000")
        Replace = ColA.createSearchDescriptor()
        Replace.SearchString = tkr
        Search_Result = ColA.findAll(Replace)
        time.sleep(.1) # // FIXME:
# Traceback (most recent call last):
#   File "uno_qvrs.py", line 90, in <module>
#    print("{} {}".format(tkr, Last_Occur.CellAddress.Row ))
# AttributeError: CellAddress
        if ( Search_Result is None ):
            print("{} not found".format(tkr))
            # // TODO: add new row
            # continue
        else:
            Last_Occur = Search_Result.getByIndex( Search_Result.Count - 1 )
            print("{} {}".format(tkr, Last_Occur.CellAddress.Row ))
            CellAddr = Last_Occur.CellAddress
            x = CellAddr.Row + 1

            cell = sheet0.getCellRangeByName("$J"+str(x))
            cell.NumberFormat = nl
            cell.Value = float(quot[idx])

            cell = sheet0.getCellRangeByName("$BJ"+str(x))
            cell.NumberFormat = nl
            cell.Value = float(vols[idx])

            cell = sheet0.getCellRangeByName("$BX"+str(x))
            if ( rs[idx] != "n/a" ):
                cell.NumberFormat = nl
                cell.Value = float(rs[idx])
            else:
                cell.String = rs[idx]

            sheet0.getCellRangeByName("$BH"+str(x)).String \
                = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
    idx += 1;

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

columns = ["A:B", "G:J", "BD1", "BF1", "BI:BK", "BX1"]
for cols in columns:
    the_range = sheet0.getCellRangeByName("BM1")
    doc.CurrentController.select(the_range)
    the_range.Columns.IsVisible = True
    the_range.Columns.OptimalWidth = True

doc.store()
print("uno_qvrs.py-")
sys.exit(0)

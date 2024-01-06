#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_load_bhr.py [yyyymmdd]
#

import uno, sys, time, os, csv
from datetime import datetime
from com.sun.star.uno import RuntimeException
# from datetime import date
# test

yyyymmdd = sys.argv[1]
DIR0="./datafiles/taiex/board.holding"

sheet_name = "20231211"
print("uno_load_bhr.py+ "+yyyymmdd)

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
# trying:
# @see https://ask.libreoffice.org/t/why-does-desktop-getcurrentcomponent-return-none-in-pyuno/59902/5
while doc is None:
    doc = desktop.getCurrentComponent()
    numbers = doc.NumberFormats # // FIXME: only when get focused, or touched
    locale = doc.CharLocale

# instead of
# @see https://ask.libreoffice.org/t/formatting-data-cell-from-macro-in-calc/23740
try:
    nl = numbers.addNew( "###0.00",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0.00", locale, False)

sheet0 = doc.Sheets.getByName(sheet_name)
the_range = sheet0.getCellRangeByName("C:BG")
doc.CurrentController.select(the_range)
the_range.Columns.IsVisible = False
the_range = sheet0.getCellRangeByName("BI:BK")
doc.CurrentController.select(the_range)
the_range.Columns.IsVisible = False

sheet0.getCellRangeByName("$BM1").String = "董監持股比率"
the_range = sheet0.getCellRangeByName("BM1")
doc.CurrentController.select(the_range)
the_range.Columns.OptimalWidth = True

DIR0="./datafiles/taiex/board.holding/" + yyyymmdd
path0 = os.path.join(DIR0, "bholding.csv")
inf0 = open(path0, 'r')
data = list(csv.reader(inf0, delimiter=':'))
tkrs = [ x[0] for x in data ]
bhr  = [ x[1] for x in data ]
checked  = [ 0 ] * len(tkrs)
# print("# lines {}".format(len(tkrs)))

idx = 0; i = 2
for tkr in tkrs:
    if ( 1 <= idx and 4 == len(tkr) ):
        print("{}".format(tkr))
        ColA = sheet0.getCellRangeByName("A1:A3000")
        Replace = ColA.createSearchDescriptor()
        Replace.SearchString = tkr
        Search_Result = ColA.findAll(Replace)
        if ( Search_Result is None ):
            print(Search_Result)
        Num_Found = Search_Result.Count # works
        Last_Occur = Search_Result.getByIndex( Num_Found - 1)
        CellAddr = Last_Occur.CellAddress
        print("{} {}".format(tkr, CellAddr.Row))
        cell = sheet0.getCellRangeByName("$BM"+str(CellAddr.Row+1))
        cell.NumberFormat = nl
        cell.Value = float(bhr[idx])
        sheet0.getCellRangeByName("$BH"+str(i)).String \
            = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
        i += 1
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

doc.store()
print("uno_load_bhr.py-")
sys.exit(0)

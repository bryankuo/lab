#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_updateqfb2.py
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

import uno, sys, time, os, csv
from datetime import datetime
from com.sun.star.uno import RuntimeException
# from datetime import date
# test
from com.sun.star.awt import MessageBoxButtons as MSG_BUTTONS

yyyymmdd = sys.argv[1]
DIR0="./datafiles/taiex/qfbs"
NAME037="外投同買賣及異常"
NAME037_10="外投同買連2"

sheet_name = NAME037+"."+yyyymmdd
print("uno_updateqfb2.py+ "+yyyymmdd)

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
    nl = numbers.addNew( "###0",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0", locale, False)

sheet0 = doc.Sheets.getByName(sheet_name)
doc.Sheets.insertNewByName(NAME037_10,    10)
sheet7 = doc.Sheets.getByName(NAME037_10)

DIR0="./datafiles/taiex/qfbs"
nm0 = NAME037_10 + "." + yyyymmdd + '.txt'
path0 = os.path.join(DIR0, nm0)
inf0 = open(path0, 'r')
data = list(csv.reader(inf0, delimiter=':'))
tkrs = [ x[0] for x in data ]

checked  = [ 0 ] * len(tkrs)
# print("# lines {}".format(len(tkrs)))

new_sheet = doc.Sheets.getByName(NAME037_10)
doc.CurrentController.setActiveSheet(new_sheet)
new_sheet.getCellRangeByName("$A1").String = "代  號"

idx = 0; i = 2
for tkr in tkrs:
    if ( 0 <= idx and 4 == len(tkr) ):
        new_sheet.getCellRangeByName("$A"+str(i)).Value = int(tkr)
        i += 1;
    idx += 1;

# assume no more than 3000 listed.
guessRange = new_sheet.getCellRangeByPosition(0, 1, 3, 3001)
cursor = new_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = new_sheet.getCellRangeByPosition(0, 1, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)
n_ticker = ( last_row - 2 ) + 1
print("# ticker {}".format(n_ticker))

the_range = new_sheet.getCellRangeByName("A2:C"+str(last_row))
doc.CurrentController.select(the_range)
the_range.NumberFormat = nl # works, setting format of a range of cells
the_range = new_sheet.getCellRangeByName("A:C")
the_range.Columns.OptimalWidth = True
doc.CurrentController.setActiveSheet(sheet0)
doc.store()
print("uno_updateqfb2.py-")
sys.exit(0)

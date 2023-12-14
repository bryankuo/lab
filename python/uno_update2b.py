#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_addsheets.py
#
# calc uno playground
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
NAME037_1="外投同買列表"
sheet_name = NAME037+"."+yyyymmdd
print("uno_update2b.py+ "+yyyymmdd)

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

active_sheet = doc.Sheets.getByName(sheet_name)
doc.Sheets.insertNewByName(NAME037_1,    1) # works

DIR0="./datafiles/taiex/qfbs"
nm0 = NAME037_1 + "." + yyyymmdd + '.txt'
path0 = os.path.join(DIR0, nm0)
inf0 = open(path0, 'r')
data = list(csv.reader(inf0, delimiter=':'))
tkrs = [ x[0] for x in data ]
name = [ x[1] for x in data ]
qb   = [ x[2] for x in data ]
fb   = [ x[3] for x in data ]
checked  = [ 0 ] * len(tkrs)
print("# lines {}".format(len(tkrs)))

new_sheet = doc.Sheets.getByName(NAME037_1)
doc.CurrentController.setActiveSheet(new_sheet)
new_sheet.getCellRangeByName("$A1").String = "代  號"
new_sheet.getCellRangeByName("$B1").String = "名  稱"
new_sheet.getCellRangeByName("$C1").String = "外資買超"
new_sheet.getCellRangeByName("$D1").String = "投信買超"

idx = 0; i = 1
for tkr in tkrs:
    new_sheet.getCellRangeByName("$A"+str(i)).String = tkr # header included
    new_sheet.getCellRangeByName("$B"+str(i)).String = name[idx]
    new_sheet.getCellRangeByName("$C"+str(i)).String = qb[idx]
    new_sheet.getCellRangeByName("$D"+str(i)).String = fb[idx]
    '''
    cell = new_sheet.getCellRangeByName("$C"+str(i))
    cell.Value= int(qb[idx])
    cell.NumberFormat = nl

    cell = new_sheet.getCellRangeByName("$D"+str(i))
    cell.Value= int(fb[idx])
    cell.NumberFormat = nl
    '''
    idx += 1; i += 1;

# assume no more than 3000 listed.
guessRange = new_sheet.getCellRangeByPosition(0, 1, 3, 3001)
# look up the actual used area within the guess area
cursor = new_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = new_sheet.getCellRangeByPosition(0, 1, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)
n_ticker = ( last_row - 2 ) + 1
print("# ticker {}".format(n_ticker))

the_range = new_sheet.getCellRangeByName("A2:D"+str(last_row))
# print(the_range.getDataArray()) # works
# print(the_range.Cells) # ng, AttributeError: Cells
doc.CurrentController.select(the_range)
the_range.NumberFormat = nl # works, setting format of a range of cells

# oCell = doc.getCurrentSelection()
# oCell.String = "oops" # // FIXME: only when get focused

# columns = new_sheet.getColumns()
# column = columns.getByName("A") # one column
the_range = new_sheet.getCellRangeByName("A:D")
the_range.Columns.OptimalWidth = True
doc.CurrentController.setActiveSheet(active_sheet)
doc.store()
print("uno_update2b.py-")
sys.exit(0)

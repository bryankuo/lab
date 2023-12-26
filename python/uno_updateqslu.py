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
NAME037_3="外資賣漲停"

sheet_name = NAME037+"."+yyyymmdd
print("uno_updateqslu.py+ "+yyyymmdd)

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
doc.Sheets.insertNewByName(NAME037_3,    3)
sheet3 = doc.Sheets.getByName(NAME037_3)
# range1 = sheet1.getCellRangeByPosition(0,0,150,5).RangeAddress

'''
# test copy
# range0 = sheet0.getCellRangeByPosition(0,0,150,5)
# assume no more than 3000 listed.
guessRange = sheet0.getCellRangeByPosition(0, 0, 10, 3000)
# look up the actual used area within the guess area
cursor = sheet0.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = sheet0.getCellRangeByPosition(0, 0, 10, len(cursor.Rows))
# print(guessRange.RangeAddress) # works
range0 = sheet0.getCellRangeByPosition(0, 0, 10, len(cursor.Rows))
range2 = sheet2.getCellRangeByPosition(0, 0, 10, len(cursor.Rows))
range2.setDataArray(range0.getDataArray()) # works
'''

DIR0="./datafiles/taiex/qfbs"
nm0 = NAME037_3 + "." + yyyymmdd + '.txt'
path0 = os.path.join(DIR0, nm0)
inf0 = open(path0, 'r')
data = list(csv.reader(inf0, delimiter=':'))
tkrs = [ x[0] for x in data ]
name = [ x[1] for x in data ]
qs   = [ x[2] for x in data ]
checked  = [ 0 ] * len(tkrs)
# print("# lines {}".format(len(tkrs)))

new_sheet = doc.Sheets.getByName(NAME037_3)
doc.CurrentController.setActiveSheet(new_sheet)
new_sheet.getCellRangeByName("$A1").String = "代  號"
new_sheet.getCellRangeByName("$B1").String = "名  稱"
new_sheet.getCellRangeByName("$C1").String = "外資賣超"

idx = 0; i = 2
for tkr in tkrs:
    if ( 0 < idx and 4 == len(tkr) ):
        new_sheet.getCellRangeByName("$A"+str(i)).Value = int(tkr)
        new_sheet.getCellRangeByName("$B"+str(i)).String = name[idx]
        new_sheet.getCellRangeByName("$C"+str(i)).Value = int(qs[idx])
        new_sheet.getCellRangeByName("$C"+str(i)).NumberFormat = nl
        i += 1;
    idx += 1;

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

the_range = new_sheet.getCellRangeByName("A2:C"+str(last_row))
# print(the_range.getDataArray()) # works
# print(the_range.Cells) # ng, AttributeError: Cells
doc.CurrentController.select(the_range)
the_range.NumberFormat = nl # works, setting format of a range of cells

# oCell = doc.getCurrentSelection()
# oCell.String = "oops" # // FIXME: only when get focused

# columns = new_sheet.getColumns()
# column = columns.getByName("A") # one column
the_range = new_sheet.getCellRangeByName("A:C")
the_range.Columns.OptimalWidth = True
doc.CurrentController.setActiveSheet(sheet0)
doc.store()
print("uno_updateqslu.py-")
sys.exit(0)

#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_formula.py [file]
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

import uno, sys, time
from datetime import datetime
from com.sun.star.uno import RuntimeException

file_name = sys.argv[1]
# assume ror.20231001.ods, sheet name : 'ror.20231001'
tokens = file_name.split('.')
sheet_name = tokens[0]+"."+tokens[1]
# print(sheet_name)

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
model = desktop.getCurrentComponent()
active_sheet = model.Sheets.getByName(sheet_name)

doc = None
numbers = None
locale = None
nl = None
# trying:
# @see https://ask.libreoffice.org/t/why-does-desktop-getcurrentcomponent-return-none-in-pyuno/59902/5
while doc is None:
    doc = desktop.getCurrentComponent()
    numbers = doc.NumberFormats
    locale = doc.CharLocale
# instead of
# @see https://ask.libreoffice.org/t/formatting-data-cell-from-macro-in-calc/23740
# doc = XSCRIPTCONTEXT.getDocument()
try:
    nl = numbers.addNew( "###0.00",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0.00", locale, False)

# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)
n_ticker = ( last_row - 2 ) + 1

def set_formula_1w():
    addr = "$L1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(1w)"
    # msgbox(cell.AbsoluteName)
    # cell.String = "a1b2c3"
    # cell_stalk.Value = 1
    # cell.Formula = "=C2+D2"
    for i in range( 2, last_row + 1 ):
        addr = "L"+str(i)
        cell = active_sheet.getCellRangeByName(addr)
        f = "=PERCENTRANK($D2:$D$"+str(last_row)+"; $D"+str(i)+")"
        cell.Formula = f
        cell.NumberFormat = nl

def set_formula_1m():
    addr = "$M1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(1m)"
    for i in range( 2, last_row + 1 ):
        addr = "M"+str(i)
        cell = active_sheet.getCellRangeByName(addr)
        f = "=PERCENTRANK($E2:$E"+str(last_row)+"; $E"+str(i)+")"
        cell.Formula = f
        cell.NumberFormat = nl

def set_formula_3m():
    addr = "$n1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(3m)"
    for i in range( 2, last_row + 1 ):
        addr = "N"+str(i)
        cell = active_sheet.getCellRangeByName(addr)
        f = "=PERCENTRANK($G2:$G"+str(last_row)+"; $G"+str(i)+")"
        cell.Formula = f
        cell.NumberFormat = nl

def set_formula_ytd():
    addr = "$O1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(ytd)"
    for i in range( 2, last_row + 1 ):
        addr = "$O"+str(i)
        cell = active_sheet.getCellRangeByName(addr)
        f = "=PERCENTRANK($J2:$J"+str(last_row)+"; $J"+str(i)+")"
        cell.Formula = f
        cell.NumberFormat = nl

set_formula_1w()
set_formula_1m()
set_formula_3m()
set_formula_ytd()

olist = [ str(last_row) ]
print(olist)

sys.exit(0)

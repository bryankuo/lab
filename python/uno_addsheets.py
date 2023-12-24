#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_addsheets.py
#
# calc uno playground
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

import uno, sys, time, os
from datetime import datetime
from com.sun.star.uno import RuntimeException
# from datetime import date
# test
from com.sun.star.beans import PropertyValue

yyyymmdd = sys.argv[1]
# sheet_name = "外投同買賣及異常."+yyyymmdd
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

# desktop = XSCRIPTCONTEXT.getDesktop() # not defined
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
# doc = XSCRIPTCONTEXT.getDocument()
try:
    nl = numbers.addNew( "###0.000",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0.000", locale, False)

# https://wiki.documentfoundation.org/Macros/Python_Guide/Useful_functions#Call_dispatch

# document = XSCRIPTCONTEXT.getDocument()
# print(document)

# DispatchCommands
# https://wiki.documentfoundation.org/Development/DispatchCommands#Base_slots_.28basslots.29

'''
def call_dispatch(doc, url, args=()):
    frame = doc.getCurrentController().getFrame()
    # dispatch = create_instance('com.sun.star.frame.DispatchHelper')
    # dispatch = smgr.createInstanceWithContext( 'com.sun.star.frame.DispatchHelper', ctx)
    # dispatch = smgr.createInstance( 'com.sun.star.frame.DispatchHelper' )
    dispatch.executeDispatch(frame, url, '', 0, args)
    return
'''

active_sheet = doc.Sheets.getByName("RS-history")
doc.CurrentController.setActiveSheet(active_sheet)
the_range = active_sheet.getCellRangeByName("A1:AMJ1048576")
the_range.Columns.OptimalWidth = True
doc.store()
the_range = active_sheet.getCellRangeByName("A1:AMJ1048576")
doc.CurrentController.select(the_range)

properties = PropertyValue()
properties.Name = 'ToPoint'
properties.Value ='B7'

dispatch = smgr.createInstanceWithContext( "com.sun.star.frame.DispatchHelper", ctx)
frame = doc.getCurrentController().getFrame()
# dispatch.executeDispatch(frame, url, '', 0, args)
dispatch.executeDispatch(frame, ".uno:GoToCell", '', 0, properties)


#call_dispatch(doc, ".uno:GoToCell", properties)

print("done.")
sys.exit(0)

# doc.Sheets.insertNewByName("外投同買列表",    1) # works
# doc.Sheets.insertNewByName("外投同賣列表",    2)
# doc.Sheets.insertNewByName("外資賣漲停",     3)
# doc.Sheets.insertNewByName("外資買跌停",     4)
doc.Sheets.insertNewByName("外資-大盤跌買入", 5)
doc.Sheets.insertNewByName("外資-大盤漲賣出", 6)
doc.Sheets.insertNewByName("外投同賣連2",     7)
doc.Sheets.insertNewByName("外投同賣新增",    8)
doc.Sheets.insertNewByName("外投同買新增",    9)
doc.Sheets.insertNewByName("外投同買連2",    10)


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

# oCell = doc.getCurrentSelection()
# oCell.String = "oops" # // FIXME: only when get focused

# columns = active_sheet.getColumns()
# column = columns.getByName("A") # one column
'''
sys.exit(0)

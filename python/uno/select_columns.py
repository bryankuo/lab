#!/usr/bin/python3

'''
/Applications/LibreOffice.app/Contents/Resources/python \
    uno/select_columns.py
'''

# qvrs "A:B","G:$j","AL1","BD1","Bi1","BX:BZ","CF:CG","CQ"
# RR   "A:B","G:H","j1","$BD1","BF1","BG1"
# margin balance
# latitude, longitude "A:B", "CU:CV"

# ETF components:
# "A:B","G:H","AL1","BD1","BZ1","CA:CB","CE1","CK:CP","CR:CT"

# dollar sign not allowed
#
# calc uno playground
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets
# Python for LibreOffice
# https://openoffice3.web.fc2.com/Python_Macro_Calc.html
# uno-commands.csv
# https://github.com/LibreOffice/help/blob/master/helpers/uno-commands.csv
import uno, sys, time, os, csv
from datetime import datetime
from com.sun.star.uno import RuntimeException
# from datetime import date
# test
from com.sun.star.beans import PropertyValue
from com.sun.star.sheet import TableFilterField # SheetFilterDescriptor
# from com.sun.star.sheet import FilterOperator # is it required?
# @see https://ask.libreoffice.org/t/calc-macro-to-filter-column-by-text-background-color/89345/2
from com.sun.star.sheet.FilterOperator \
    import EMPTY, EQUAL, GREATER_EQUAL, GREATER, \
    TOP_VALUES, BOTTOM_VALUES, NOT_EQUAL, NOT_EMPTY, \
    LESS_EQUAL

from com.sun.star.sheet.FilterConnection \
    import AND, OR

from pprint import pprint

if ( len(sys.argv) < 2 ):
    print("usage: \n" \
        "/Applications/LibreOffice.app/Contents/Resources/python \n" \
        "   select_columns.py [spec]")
    sys.exit(0)

spec = sys.argv[1]
# print(spec)
specs = spec.split(',')
pprint(specs)
# sys.exit(0)

# get the uno component context from the PyUNO runtime
localContext = uno.getComponentContext() # works
# SM = localContext.getServiceManager()    # works
# ctx = XSCRIPTCONTEXT.getComponentContext() # // FIXME:
# print(ctx)

# create the UnoUrlResolver
resolver = localContext.ServiceManager\
    .createInstanceWithContext( \
        "com.sun.star.bridge.UnoUrlResolver", localContext )

# connect to the running office
ctx = resolver.resolve(
    "uno:socket,host=localhost,port=2002;urp;StarOffice.ComponentContext" )
smgr = ctx.ServiceManager                # different service manager

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
try:
    nl = numbers.addNew( "###0",  locale )
    # nl2 = numbers.addNew( "###0.000",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0", locale, False)
    # nl2 = numbers.addNew( "###0.000",  locale )

try:
    sheet_name = "20231211"
    sheet0 = doc.Sheets.getByName(sheet_name)
    columns = sheet0.getColumns()
    columns.IsVisible = False
    # columns = ["A:B", "G:J", "I1", "BD1", "BF1", "BI:BK", "BX1"]
    columns = specs
    for cols in columns:
        the_range = sheet0.getCellRangeByName(cols)
        doc.CurrentController.select(the_range)
        the_range.Columns.IsVisible = True
        the_range.Columns.OptimalWidth = True

    '''
    guessRange = sheet0.getCellRangeByPosition(0, 1, 3, 3001)
    cursor = sheet0.createCursorByRange(guessRange)
    cursor.gotoEndOfUsedArea(False)
    cursor.gotoStartOfUsedArea(True)
    guessRange = sheet0.getCellRangeByPosition(0, 1, 0, len(cursor.Rows))
    # print(guessRange.getDataArray())
    last_row = len(cursor.Rows)
    n_ticker = ( last_row - 2 ) + 1
    # print("sheet0 # ticker {}".format(n_ticker))
    '''

    dispatch = smgr.createInstanceWithContext( \
        "com.sun.star.frame.DispatchHelper", localContext)

    frame = doc.CurrentController.getFrame()
    oProp = PropertyValue()
    oProp.Name = 'ToPoint'
    oProp.Value = '$a2'
    properties = (oProp,)
    dispatch.executeDispatch(frame, ".uno:GoToCell", "", 0, properties)

except:
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass

# doc.store() # test

print("done.\a\n")
sys.exit(0)

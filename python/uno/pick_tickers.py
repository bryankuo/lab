#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  pick_tickers.py [tickers]
#
# \param in  a list of tickers
# \param out calc filtered by given tickers
#
import uno, sys, time, os, csv
from datetime import datetime
from pprint import pprint
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

tickers = sys.argv[1]
tkr_l = tickers[1:-1].strip(' ').split(',')
tkr_l = list(map(int, tkr_l))
# pprint(tkr_l)

localContext = uno.getComponentContext()

resolver = localContext.ServiceManager\
    .createInstanceWithContext( \
        "com.sun.star.bridge.UnoUrlResolver", localContext )

# connect to the running office
ctx = resolver.resolve(
    "uno:socket,host=localhost,port=2002;urp;StarOffice.ComponentContext" )
smgr = ctx.ServiceManager                # different service manager

# get the central desktop object
desktop = smgr.createInstanceWithContext( "com.sun.star.frame.Desktop",ctx)

doc = None
numbers = None
locale = None
nl = None
while doc is None:
    doc = desktop.getCurrentComponent()
    numbers = doc.NumberFormats # // FIXME: only when get focused, or touched
    locale = doc.CharLocale

try:
    nl = numbers.addNew( "###0",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0", locale, False)

try:
    sheet_name = "20231211"
    sheet0 = doc.Sheets.getByName(sheet_name)
    columns = sheet0.getColumns()
    columns.IsVisible = False
    columns = ["A:B", "G:J", "BD1", "BI:BJ", "BX1"]
    for cols in columns:
        the_range = sheet0.getCellRangeByName(cols)
        doc.CurrentController.select(the_range)
        the_range.Columns.IsVisible = True
        the_range.Columns.OptimalWidth = True

    guessRange = sheet0.getCellRangeByPosition(0, 1, 3, 3001)
    cursor = sheet0.createCursorByRange(guessRange)
    cursor.gotoEndOfUsedArea(False)
    cursor.gotoStartOfUsedArea(True)
    guessRange = sheet0.getCellRangeByPosition(0, 1, 0, len(cursor.Rows))
    # print(guessRange.getDataArray())
    last_row = len(cursor.Rows)
    n_ticker = ( last_row - 2 ) + 1
    # print("sheet0 # ticker {}".format(n_ticker))

    dispatch = smgr.createInstanceWithContext( \
        "com.sun.star.frame.DispatchHelper", localContext)

    frame = doc.CurrentController.getFrame()
    # https://forum.openoffice.org/en/forum/viewtopic.php?t=63933
    # @see https://forum.openoffice.org/en/forum/viewtopic.php?p=283539#p283539
    oProp = PropertyValue()
    oProp.Name = 'ToPoint'
    oProp.Value = '$a2'
    properties = (oProp,)
    dispatch.executeDispatch(frame, ".uno:GoToCell", "", 0, properties) # works

    # with no parameters # works
    # dispatch.executeDispatch(frame, ".uno:DataFilterAutoFilter", '', 0, ())
    # 'clear' filter works, not filter criteria
    # dispatch.executeDispatch(frame, ".uno:DataFilterRemoveFilter", '', 0, ())

    # filter with criteria
    # .uno:DataFilterStandardFilter
    # single filter
    # @see https://marc.info/?l=openoffice-users&m=111523270761630

    # https://wiki.documentfoundation.org/Documentation/DevGuide/Spreadsheet_Documents

    # createFilterDescriptor example
    # https://wiki.documentfoundation.org/Macros/Calc/ba026
    oFilterDesc = sheet0.createFilterDescriptor(True)
    # print(oFilterDesc) # ok

    # https://forum.openoffice.org/en/forum/viewtopic.php?p=519743&sid=d8177b32c6db9f8abd6a755cb0001399#p519743
    # // TODO: add multiple to tuple
    # multiple tickers
    # @see https://forum.openoffice.org/en/forum/viewtopic.php?t=106854
    # oFields = (TableFilterField()) * len(tkr_l) # NG
    oFields = ()
    for i in range( 0, len(tkr_l) ):
        aFilterField = TableFilterField()
        # aFilterField.Field = 0 # works, zero-based index
        aFilterField.IsNumeric = True
        aFilterField.Operator = EQUAL
        aFilterField.NumericValue = tkr_l[i]
        if ( 0 < i ):
            aFilterField.Connection = AND
            oFields = oFields + (aFilterField) # NG, unsupported operand type(s)
        else:
            oFields = (aFilterField)
    # oFields = TableFilterField(len(tkr_l)) # NG
    # value cannot be converted to demanded ENUM!
    # oFields = TableFilterField(2)
    print(oFields)
    sys.exit(0)
    oFilterDesc.setFilterFields(oFields)
    oFilterDesc.ContainsHeader = True
    sheet0.filter(oFilterDesc) # works

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass

# doc.store()

# doc.close() // FIXME:
# // TODO: delete new_sheet

print("done.\a\n")
sys.exit(0)

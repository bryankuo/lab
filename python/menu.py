#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  menu.py
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

# yyyymmdd = sys.argv[1]

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
    columns = ["A:B", "G:J", "I1", "BD1", "BI:BK", "BX1"]
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
    dispatch.executeDispatch(frame, ".uno:DataFilterRemoveFilter", '', 0, ())

    # filter with criteria
    # .uno:DataFilterStandardFilter
    # single filter
    # @see https://marc.info/?l=openoffice-users&m=111523270761630
    # @see https://www.openoffice.org/api/docs/common/ref/com/sun/star/sheet/TableFilterField.html
    # https://wiki.documentfoundation.org/Documentation/DevGuide/Spreadsheet_Documents

    # createFilterDescriptor example
    # https://wiki.documentfoundation.org/Macros/Calc/ba026
    oFilterDesc = sheet0.createFilterDescriptor(True)
    # print(oFilterDesc) # ok
    # aFilterField = com.sun.star.sheet.TableFilterField
    aFilterField = TableFilterField()
    aFilterField.Field = 55 # BD
    # aFilterField.Field = 0 # works, zero-based index
    aFilterField.IsNumeric = True
    aFilterField.Operator = GREATER_EQUAL
    aFilterField.NumericValue = 2.0
    # aFilterField.NumericValue = 1101
    # print(aFilterField) # ok

    aFilterField1 = TableFilterField()
    aFilterField1.Connection = AND # ok
    aFilterField1.Field = 55 # BD
    aFilterField1.IsNumeric = True
    aFilterField1.Operator = LESS_EQUAL
    aFilterField1.NumericValue = 3.3
    # print(aFilterField1)

    oFields = (aFilterField, aFilterField1,) # tuple
    oFilterDesc.setFilterFields(oFields)
    oFilterDesc.ContainsHeader = True
    # sheet0.filter(oFilterDesc) # works

    # dispatch.executeDispatch( \
    #    frame, ".uno:DataFilterStandardFilter", '', 0, oFields) # NG

    # ".uno:FilterExecute"
    # dispatch.executeDispatch(frame, ".uno:FilterExecute", '', 0, ())


    # Dispatch commands by application
    # https://wiki.documentfoundation.org/Development/DispatchCommands#Base_slots_.28basslots.29
    # @see https://wiki.documentfoundation.org/Macros/Python_Guide/Useful_functions
    # list of uno commands @see
    # https://github.com/LibreOffice/help/blob/master/helpers/uno-commands.csv

    # dispatch.executeDispatch(frame, ".uno:SortDescending", "", 0, ()) # works

    # OpenOffice.org Macro Information By Andrew Pitonyak
        # https://www.pitonyak.org/oo.php

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

# LO python path:
#
# Python Scripts Organization and Location
# @see https://help.libreoffice.org/latest/sq/text/sbasic/python/python_locations.html
#
# Application Macros
# @see https://ask.libreoffice.org/t/python-macros-on-libreoffice-on-os-x/18135
# ls -lt /Applications/LibreOffice.app/Contents/Resources/Scripts/python/
#
# My Macros
#
# Document macros
#

# oCell = doc.getCurrentSelection()
# oCell.String = "oops" # // FIXME: only when get focused

# columns = sheet0.getColumns()
# column = columns.getByName("A") # one column
'''
sys.exit(0)

remove security warning and backup basic dispatch here
original activity_watchlist.ods, standard, module1
1. LO preference set low macro security
2. warning comes from setting, not checking if any macro in the path
#
REM  *****  BASIC  *****

sub ShowAllColumns
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:ShowColumn", "", 0, Array())

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:ShowColumn", "", 0, Array())


end sub


sub AutoFilterOptimalWidth
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:DataFilterAutoFilter", "", 0, Array())

rem ----------------------------------------------------------------------
dim args2(0) as new com.sun.star.beans.PropertyValue
args2(0).Name = "aExtraWidth"
args2(0).Value = 200

dispatcher.executeDispatch(document, ".uno:SetOptimalColumnWidth", "", 0, args2())


end sub


sub GotoA1
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dim args1(0) as new com.sun.star.beans.PropertyValue
args1(0).Name = "ToPoint"
args1(0).Value = "$A$1"

dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args1())


end sub


sub SelectAll
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:SelectAll", "", 0, Array())


end sub


sub AutoFilter
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:DataFilterAutoFilter", "", 0, Array())


end sub


sub To1211
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dim args1(0) as new com.sun.star.beans.PropertyValue
args1(0).Name = "Nr"
args1(0).Value = 8

dispatcher.executeDispatch(document, ".uno:JumpToTable", "", 0, args1())


end sub

sub optimalWidth
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:SelectAll", "", 0, Array())

rem ----------------------------------------------------------------------
dim args2(0) as new com.sun.star.beans.PropertyValue
args2(0).Name = "aExtraWidth"
args2(0).Value = 1930

dispatcher.executeDispatch(document, ".uno:SetOptimalColumnWidth", "", 0, args2())

rem ----------------------------------------------------------------------
dim args3(0) as new com.sun.star.beans.PropertyValue
args3(0).Name = "ToPoint"
args3(0).Value = "$B$1164"

dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args3())

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:Save", "", 0, Array())


end sub


sub Restore5
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:SelectAll", "", 0, Array())

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:ShowColumn", "", 0, Array())

rem ----------------------------------------------------------------------
dim args3(0) as new com.sun.star.beans.PropertyValue
args3(0).Name = "aExtraWidth"
args3(0).Value = 200

dispatcher.executeDispatch(document, ".uno:SetOptimalColumnWidth", "", 0, args3())

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:DataFilterAutoFilter", "", 0, Array())

rem ----------------------------------------------------------------------
dim args5(0) as new com.sun.star.beans.PropertyValue
args5(0).Name = "aExtraWidth"
args5(0).Value = 200

dispatcher.executeDispatch(document, ".uno:SetOptimalColumnWidth", "", 0, args5())

dispatcher.executeDispatch(document, ".uno:DataSort", "", 0, Array())

dim args9(0) as new com.sun.star.beans.PropertyValue
args9(0).Name = "aExtraWidth"
args9(0).Value = 200

dispatcher.executeDispatch(document, ".uno:SetOptimalColumnWidth", "", 0, args9())

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:Save", "", 0, Array())

rem ----------------------------------------------------------------------
dim args11(0) as new com.sun.star.beans.PropertyValue
args11(0).Name = "ToPoint"
args11(0).Value = "$A$2"

dispatcher.executeDispatch(document, ".uno:GoToCell", "", 0, args11())


end sub

sub SortColumnA1Ascending
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:SortAscending", "", 0, Array())

rem ----------------------------------------------------------------------
rem dispatcher.executeDispatch(document, ".uno:Undo", "", 0, Array())

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:SortAscending", "", 0, Array())


end sub


sub Restore6
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:DataFilterAutoFilter", "", 0, Array())

rem ----------------------------------------------------------------------
dispatcher.executeDispatch(document, ".uno:DataFilterAutoFilter", "", 0, Array())


end sub


sub SortAsc
rem ----------------------------------------------------------------------
rem define variables
dim document   as object
dim dispatcher as object
rem ----------------------------------------------------------------------
rem get access to the document
document   = ThisComponent.CurrentController.Frame
dispatcher = createUnoService("com.sun.star.frame.DispatchHelper")

rem ----------------------------------------------------------------------
rem dispatcher.executeDispatch(document, ".uno:DataSort", "", 0, Array())


end sub
'''

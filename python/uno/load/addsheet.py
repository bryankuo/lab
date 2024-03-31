#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_addsheets.py
#
# calc uno playground
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets
# Python for LibreOffice
# https://openoffice3.web.fc2.com/Python_Macro_Calc.html
import uno, sys, time, os, csv
from datetime import datetime
from com.sun.star.uno import RuntimeException
# from datetime import date
# test
from com.sun.star.beans import PropertyValue

yyyymmdd = sys.argv[1]

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

'''
def create_instance(name, with_context=False):
    if with_context:
        # instance = SM.createInstanceWithContext(name, CTX)
         instance = SM.createInstanceWithContext(name, localContext)
    else:
        instance = SM.createInstance(name)
    return instance
'''

# Dispatch commands by application
# https://wiki.documentfoundation.org/Development/DispatchCommands#Base_slots_.28basslots.29
# @see https://wiki.documentfoundation.org/Macros/Python_Guide/Useful_functions
# list of uno commands @see
# https://github.com/LibreOffice/help/blob/master/helpers/uno-commands.csv
'''
def call_dispatch(doc, url, args=()):
    frame = doc.getCurrentController().getFrame()
    dispatch = create_instance('com.sun.star.frame.DispatchHelper')
    dispatch.executeDispatch(frame, url, '', 0, args)
    return
'''

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


try:
    sheet_name = "20231211"
    active_sheet = doc.Sheets.getByName(sheet_name)
    hide_lst = ["C:I", "K:CB", "cD1"]
    for r in hide_lst:
        the_range = active_sheet.getCellRangeByName(r)
        doc.CurrentController.select(the_range)
        the_range.Columns.IsVisible = False

    opt_lst = ["A:B", "$j1", "cC1"]
    for r in opt_lst:
        the_range = active_sheet.getCellRangeByName(r)
        doc.CurrentController.select(the_range)
        the_range.Columns.IsVisible = True
        the_range.Columns.OptimalWidth = True

    doc.Sheets.insertNewByName("創新高天數."+yyyymmdd, doc.Sheets.Count+1 )
    new_sheet = doc.Sheets.getByName("創新高天數."+yyyymmdd)
    doc.CurrentController.setActiveSheet(new_sheet)
    new_sheet.getCellRangeByName("$A1").String = "代  號"
    new_sheet.getCellRangeByName("$B1").String = "創新高天數"

    # path0 = os.path.join(DIR0, nm0)
    path0 = "./ndays_high.20240317.csv"
    inf0 = open(path0, 'r')
    data = list(csv.reader(inf0, delimiter=':'))
    tkrs = [ x[0] for x in data ]
    ndays= [ x[1] for x in data ]
    checked  = [ 0 ] * len(tkrs)
    idx = 0; i = 2
    for tkr in tkrs:
        if ( 0 < idx and 4 == len(tkr) ):
            new_sheet.getCellRangeByName("$A"+str(i)).Value = int(tkr)
            new_sheet.getCellRangeByName("$B"+str(i)).Value = ndays[idx]
            # print("{} {}\n".format(i, ndays))
            i += 1;
        idx += 1;

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass


dispatch = smgr.createInstanceWithContext( \
    "com.sun.star.frame.DispatchHelper", localContext)

frame = doc.CurrentController.getFrame()
# https://forum.openoffice.org/en/forum/viewtopic.php?t=63933
# @see https://forum.openoffice.org/en/forum/viewtopic.php?p=283539#p283539
oProp = PropertyValue()
oProp.Name = 'ToPoint'
oProp.Value = 'C2'
properties = (oProp,)
dispatch.executeDispatch(frame, ".uno:GoToCell", "", 0, properties) # works

# with no parameters
dispatch.executeDispatch(frame, ".uno:DataFilterAutoFilter", '', 0, ()) # works
doc.store()
# doc.close() // FIXME:
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

# columns = active_sheet.getColumns()
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

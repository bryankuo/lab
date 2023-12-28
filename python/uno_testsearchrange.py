#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python uno_test.py
#
import uno, sys, time, os, csv
from datetime import datetime
from com.sun.star.uno import RuntimeException
# from datetime import date
# test
from com.sun.star.awt import MessageBoxButtons as MSG_BUTTONS

DIR0="./datafiles"

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

sheet3 = doc.Sheets.getByName("RS-TWSE")
doc.CurrentController.setActiveSheet(sheet3)
# ColA = sheet3.getCellRangeByName("A1:C3") # 65536")
ColA = sheet3.getCellRangeByName("A1:C65536")
Replace = ColA.createSearchDescriptor()
# Replace.SearchString = "TWSE" # works
# Replace.SearchString = "15228.97" works
# Replace.SearchString = "1101" # text link not works, text is ok

# don't know how to search cell with formula, or text cell is a link
# Replace.SearchString = "#REF!" # don't know how to search
Replace.SearchString = "3"
Replace.ReplaceString ="NYSE"
Search_Result = ColA.findAll(Replace)
# https://forum.openoffice.org/en/forum/viewtopic.php?p=168905&sid=febb824751617104e17a8f8b15835e30#p168905
if ( Search_Result is None ):
    print(Search_Result)
    sys.exit(0)

Num_Found = Search_Result.Count # works
Last_Occur = Search_Result.getByIndex( Num_Found - 1)
# get the Cell containing the last "Menu", need the -1 because indexes start at zero
CellAddr = Last_Occur.CellAddress
print(CellAddr)
oRow = CellAddr.Row
oCol = CellAddr.Column
NewCell = sheet3.getCellByPosition(oCol, oRow)
doc.CurrentController.select(NewCell)
print("done {} {} {}".format(Num_Found, oCol, oRow))
sys.exit(0)

#!/usr/bin/python3

# python3 uno_kicks.py [ticker] [quote]

# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

# import socket  # only needed on win32-OOo3.0.0
import uno
import sys
from datetime import datetime
import time

# https://bit.ly/3sQRR4C
# import msgbox
# from pythonscript import ScriptContext

# /Applications/LibreOffice.app/Contents/Resources/python \
#   uno_kicks.py 1101 45.05
ticker = sys.argv[1]
quote = sys.argv[2]

'''
list2 = []
f = open("datafiles/listed_2.txt", "r")
raw_list = f.readlines()
for element in raw_list:
    list2.append(element.strip())
'''

def msg_box(text):
    # myBox = msgbox.MsgBox(XSCRIPTCONTEXT.getComponentContext())
    # myBox = msgbox.MsgBox(uno.getComponentContext())
    myBox.addButton("OK")
    myBox.renderFromButtonSize()
    myBox.numberOflines = 2
    myBox.show(text,0,"Not in the List")

# get the uno component context from the PyUNO runtime
localContext = uno.getComponentContext()

# create the UnoUrlResolver
resolver = localContext.ServiceManager.createInstanceWithContext("com.sun.star.bridge.UnoUrlResolver", localContext )

# connect to the running office
ctx = resolver.resolve( "uno:socket,host=localhost,port=2002;urp;StarOffice.ComponentContext" )
smgr = ctx.ServiceManager

# get the central desktop object
desktop = smgr.createInstanceWithContext( "com.sun.star.frame.Desktop",ctx)

# access the current writer document
model = desktop.getCurrentComponent()
# try to move cursor to the center of sheet
#cursor = desktop.getCurrentComponent() \
#    .getCurrentController().getViewCursor()

# @see http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html
# sheet_name = "20220126"
# sheet = model.Sheets.getByName(sheet_name)
# model.getCurrentController.setActiveSheet(sheet) # set the sheet active
# access the active sheet
active_sheet = model.CurrentController.ActiveSheet


# access cell C4
# cell1 = active_sheet.getCellRangeByName("j501")

# set text inside
# cell1.String = ticker # "28.42" # "Hello world"
# cell1.CellBackColor=0xFF0000 # (red)

# other example with a value
# cell2 = active_sheet.getCellRangeByName("E6")
# cell2.Value = cell2.Value + 1

# loop over existing rows
# https://ask.libreoffice.org/t/macro-how-to-loop-over-existing-rows/43274/4
cursor = active_sheet.createCursor()
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
# print(len(cursor.Rows))
addr_q = "J1" # initial
addr_resist = "G1"
addr_support = "H1"
addr_cheap = "I1"
addr_52lo = "K1"
addr_52hi = "M1"
cellq = active_sheet.getCellRangeByName(addr_q)
for i in range(1, len(cursor.Rows)):
    addr_x = "A"+str(i+1)
    cellx = active_sheet.getCellRangeByName(addr_x)
    if ( cellx.String == ticker ):
        addr_q = "J"+str(i+1)
        addr_resist = "G"+str(i+1)
        addr_support = "H"+str(i+1)
        addr_cheap = "I"+str(i+1)
        addr_52lo = "K"+str(i+1)
        addr_52hi = "M"+str(i+1)
        break

if ( addr_q == "J1" ):
    print(ticker + " not found in calc")
    sys.exit(1)
# found.

cellq = active_sheet.getCellRangeByName(addr_q)
cellq.String = quote
cellq.CellBackColor = 0xFFFF00
time.sleep(.6)
cellq.CellBackColor = 0xFFFFFF
cell = active_sheet.getCellRangeByName(addr_cheap)
if ( cell.Value <= float(quote) ):
    cell = active_sheet.getCellRangeByName(addr_cheap)
    cell.CellBackColor = 0xFFFF00
# //TODO: multithreading
sys.exit(0)

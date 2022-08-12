#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_activity.py [ticker] [qdi] [fund] [retail] [total]
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

import uno, sys, time
from datetime import datetime

MAX_ARG_LEN = 6
if ( len(sys.argv) == MAX_ARG_LEN ):
    ticker    = sys.argv[1]
    qdi       = sys.argv[2]
    fund      = sys.argv[3]
    retail    = sys.argv[4]
    d5total   = sys.argv[5]
else:
    printf('illegal # argv')
    sys.exit(0)

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
active_sheet = model.Sheets.getByName("20220126")

# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)

addr_q     = "J1" # initial
addr_x = "A1"

addr_qdi = "C1"
addr_fund = "D1"
addr_retail = "E1"
addr_5dtotal = "F1"

def set_value():
    cell_ticker = active_sheet.getCellRangeByName(addr_qdi)
    cell_ticker.String = qdi
    cell_ticker = active_sheet.getCellRangeByName(addr_fund)
    cell_ticker.String = fund
    cell_ticker = active_sheet.getCellRangeByName(addr_retail)
    cell_ticker.String = retail
    cell_ticker = active_sheet.getCellRangeByName(addr_5dtotal)
    cell_ticker.String = d5total

cellq = active_sheet.getCellRangeByName(addr_q)
for i in range(2, last_row):
    addr_x = "A" + str(i)
    cellx = active_sheet.getCellRangeByName(addr_x)
    if ( cellx.String == ticker ):
        addr_q = "J" + str(i)
        addr_qdi = "C" + str(i)
        addr_fund = "D" + str(i)
        addr_retail = "E" + str(i)
        addr_5dtotal = "F" + str(i)
        break

if ( addr_q == "J1" ):
    # print(ticker + corp_name + " not found in sheet, add entry,")
    addr_x = "A" + str( last_row + 1 )
    addr_qdi = "C" + str( last_row + 1 )
    addr_fund = "D" + str( last_row + 1 )
    addr_retail = "E" + str( last_row + 1 )
    addr_5dtotal = "F" + str( last_row + 1 )
    # addr_stalk = "AE" + str( last_row + 1 )
    # cell_ticker = active_sheet.getCellRangeByName(addr_x)
    # cell_ticker.String = ticker

set_value()

out_of_spec = 0
# cell_stalk = active_sheet.getCellRangeByName(addr_stalk)
# if ( out_of_spec ):
#     cell_stalk.Value = 1
# else:
#     cell_stalk.String = ""
# @see ref: shorturl.at/lsuHT

olist = [ out_of_spec ]
print(olist)

sys.exit(0)

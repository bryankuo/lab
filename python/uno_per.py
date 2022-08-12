#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_per.py [ticker] [deal] [per] [p52h] [p52l] [p52peer]
#
# reference: uno_activity.py
# set bounty column to 1 for filtering
# and clear bounty bit in calc

import uno, sys, time
from datetime import datetime

MAX_ARG_LEN = 7
if ( len(sys.argv) == MAX_ARG_LEN ):
    ticker    = sys.argv[1]
    quote     = sys.argv[2]
    per       = sys.argv[3]
    per_hi52  = sys.argv[4]
    per_lo52  = sys.argv[5]
    per_peer  = sys.argv[6]
else:
    print('illegal # argv')
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

addr_q        = "J1" # initial
addr_x        = "A1"

addr_per      = "O1"
addr_per_h52  = "P1"
addr_per_l52  = "Q1"
addr_per_peer = "R1"
addr_bounty   = "AG1"

def set_value():
    cell_ticker = active_sheet.getCellRangeByName(addr_q)
    cell_ticker.String = quote
    cell_ticker = active_sheet.getCellRangeByName(addr_per)
    cell_ticker.String = per
    cell_ticker = active_sheet.getCellRangeByName(addr_per_h52)
    cell_ticker.String = per_hi52
    cell_ticker = active_sheet.getCellRangeByName(addr_per_l52)
    cell_ticker.String = per_lo52
    cell_ticker = active_sheet.getCellRangeByName(addr_per_peer)
    cell_ticker.String = per_peer

cellq = active_sheet.getCellRangeByName(addr_q)
for i in range(2, last_row):
    addr_x = "A" + str(i)
    cellx = active_sheet.getCellRangeByName(addr_x)
    if ( cellx.String == ticker ):
        addr_q        = "J" + str(i)
        addr_per      = "O" + str(i)
        addr_per_h52  = "P" + str(i)
        addr_per_l52  = "Q" + str(i)
        addr_per_peer = "R"  + str(i)
        addr_bounty   = "AG" + str(i)
        break

if ( addr_q == "J1" ):
    # print(ticker + corp_name + " not found in sheet, add entry,")
    addr_x        = "A"  + str( last_row + 1 )
    addr_q        = "J"  + str( last_row + 1 )
    addr_per      = "O"  + str( last_row + 1 )
    addr_per_h52  = "P"  + str( last_row + 1 )
    addr_per_l52  = "Q"  + str( last_row + 1 )
    addr_per_peer = "R"  + str( last_row + 1 )
    addr_bounty   = "AG" + str( last_row + 1 )
    cell_ticker = active_sheet.getCellRangeByName(addr_x)
    cell_ticker.String = ticker

set_value()

cellq = active_sheet.getCellRangeByName(addr_q)
cellq.String = quote
cellq.CellBackColor = 0xFFFF00
time.sleep(.3)
cellq.CellBackColor = 0xFFFFFF
cellb = active_sheet.getCellRangeByName(addr_bounty)
cellb.Value = 1

out_of_spec = 0

olist = [ out_of_spec ]
print(olist)

sys.exit(0)

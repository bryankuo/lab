#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_story.py [ticker] [story]
#
# reference: uno_per.py
# set bounty column to 1 for filtering
# and clear bounty bit in calc before start

import uno, sys, time
from datetime import datetime

MAX_ARG_LEN = 3
if ( len(sys.argv) == MAX_ARG_LEN ):
    ticker    = sys.argv[1]
    story     = sys.argv[2]
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
active_sheet = model.CurrentController.ActiveSheet

# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)

# print("hello")
# print(sys.argv[1])
# print(sys.argv[2])
# olist = [ story, sys.argv[1] ]
# print(olist)
# sys.exit(0)

addr_q        = "J1" # initial
addr_x        = "A1"

addr_story    = "AD1"
addr_bounty   = "AG1"

new_story = ""

def set_value():
    cell_ticker = active_sheet.getCellRangeByName(addr_story)
    cell_ticker.CellBackColor = 0xFFFF00
    prev_story  = cell_ticker.String
    if 0 < len(prev_story) :
        if story not in prev_story :
            cell_ticker.String = prev_story + ":" + story
            # new_story = cell_ticker.String # // FIXME
    else:
        cell_ticker.String = story
        new_story = cell_ticker.String
    time.sleep(.3)
    cell_ticker.CellBackColor = 0xFFFFFF
    # new_story = cell_ticker.String
    cell_q = active_sheet.getCellRangeByName(addr_q)
    cell_q.Value = 0

cellq = active_sheet.getCellRangeByName(addr_q)
for i in range(2, last_row):
    addr_x = "A" + str(i)
    cellx = active_sheet.getCellRangeByName(addr_x)
    if ( cellx.String == ticker ):
        addr_q        = "J"  + str(i)
        addr_story    = "AD" + str(i)
        addr_bounty   = "AG" + str(i)
        break

if ( addr_q == "J1" ):
    # print(ticker + corp_name + " not found in sheet, add entry,")
    addr_x        = "A"  + str( last_row + 1 )
    addr_q        = "J"  + str( last_row + 1 )
    addr_story    = "AD" + str( last_row + 1 )
    addr_bounty   = "AG" + str( last_row + 1 )
    cell_ticker = active_sheet.getCellRangeByName(addr_x)
    cell_ticker.String = ticker

set_value()

# cellq = active_sheet.getCellRangeByName(addr_q)
# cellq.String = quote
cellb = active_sheet.getCellRangeByName(addr_bounty)
cellb.Value = 1

out_of_spec = 0

olist = [ new_story ]
print(olist)

sys.exit(0)

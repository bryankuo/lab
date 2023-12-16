#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_eps.py [ticker] [q0] [q1] [q2] [q3] [q4] [q5] [q6] [q7] [q8] [q9]
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

# import socket  # only needed on win32-OOo3.0.0
import uno, sys, time
from datetime import datetime

MAX_ARG_LEN = 12
if ( len(sys.argv) == MAX_ARG_LEN ):
    ticker    = sys.argv[1]
    epsq0   = sys.argv[2]
    epsq1   = sys.argv[3]
    epsq2   = sys.argv[4]
    epsq3   = sys.argv[5]
    epsq4   = sys.argv[6]
    epsq5   = sys.argv[7]
    epsq6   = sys.argv[8]
    epsq7   = sys.argv[9]
    epsq8   = sys.argv[10]
    epsq9   = sys.argv[11]
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
active_sheet = model.Sheets.getByName("20231211")

# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)

addr_q      = "J1" # initial
addr_x      = "A1"

addr_eps0 = "S1" # 2022Q4 est.

addr_eps1 = "T1"
addr_eps2 = "U1"
addr_eps3 = "V1"
addr_eps4 = "W1"
addr_eps5 = "X1"

addr_eps6 = "Y1"
addr_eps7 = "Z1"
addr_eps8 = "AA1"
addr_eps9 = "AB1"
addr_eps10 = "AC1" # goodinfo but not set value

addr_stalk = "AE1"

def set_value():
    cell_ticker = active_sheet.getCellRangeByName(addr_eps1)
    cell_ticker.String = epsq0
    cell_ticker = active_sheet.getCellRangeByName(addr_eps2)
    cell_ticker.String = epsq1
    cell_ticker = active_sheet.getCellRangeByName(addr_eps3)
    cell_ticker.String = epsq2
    cell_ticker = active_sheet.getCellRangeByName(addr_eps4)
    cell_ticker.String = epsq3
    cell_ticker = active_sheet.getCellRangeByName(addr_eps5)
    cell_ticker.String = epsq4
    cell_ticker = active_sheet.getCellRangeByName(addr_eps6)
    cell_ticker.String = epsq5
    cell_ticker = active_sheet.getCellRangeByName(addr_eps7)
    cell_ticker.String = epsq6
    cell_ticker = active_sheet.getCellRangeByName(addr_eps8)
    cell_ticker.String = epsq7
    cell_ticker = active_sheet.getCellRangeByName(addr_eps9)
    cell_ticker.String = epsq8
    cell_ticker = active_sheet.getCellRangeByName(addr_eps10)
    cell_ticker.String = epsq9

cellq = active_sheet.getCellRangeByName(addr_q)
for i in range(2, last_row):
    addr_x = "A" + str(i)
    cellx = active_sheet.getCellRangeByName(addr_x)
    if ( cellx.String == ticker ):
        addr_q = "J" + str(i)
        addr_eps0 = "S" + str(i)
        addr_eps1 = "T" + str(i)
        addr_eps2 = "U" + str(i)
        addr_eps3 = "V" + str(i)

        addr_eps4 = "W" + str(i)
        addr_eps5 = "X" + str(i)
        addr_eps6 = "Y" + str(i)
        addr_eps7 = "Z" + str(i)

        addr_eps8 = "AA" + str(i)
        addr_eps9 = "AB" + str(i)
        addr_eps10 = "AC" + str(i)

        addr_stalk = "AE" + str(i)
        break

if ( addr_q == "J1" ):
    # print(ticker + corp_name + " not found in sheet, add entry,")
    addr_x = "A" + str( last_row + 1 )
    addr_eps0 = "S" + str( last_row + 1 ) # est. is blank

    addr_eps1 = "T" + str( last_row + 1 ) # goodifno start here
    addr_eps2 = "U" + str( last_row + 1 )
    addr_eps3 = "V" + str( last_row + 1 )
    addr_eps4 = "W" + str( last_row + 1 )
    addr_eps5 = "X" + str( last_row + 1 )

    addr_eps6 = "Y" + str( last_row + 1 )
    addr_eps7 = "Z" + str( last_row + 1 )
    addr_eps8 = "AA" + str( last_row + 1 )
    addr_eps9 = "AB" + str( last_row + 1 )
    addr_eps10 = "AC" + str( last_row + 1 )

    addr_stalk = "AE" + str( last_row + 1 )
    cell_ticker = active_sheet.getCellRangeByName(addr_x)
    cell_ticker.String = ticker

set_value()

out_of_spec = 0
if ( float(epsq1) <= float(epsq0) and
    float(epsq2) <= float(epsq1) ):
    out_of_spec = 1
    cell = active_sheet.getCellRangeByName(addr_eps1)
    cell.CellBackColor = 0xFFFF00
    cell = active_sheet.getCellRangeByName(addr_eps2)
    cell.CellBackColor = 0xFFFF00
    cell = active_sheet.getCellRangeByName(addr_eps3)
    cell.CellBackColor = 0xFFFF00
else:
    cell = active_sheet.getCellRangeByName(addr_eps1)
    cell.CellBackColor = 0xFFFFFF
    cell = active_sheet.getCellRangeByName(addr_eps2)
    cell.CellBackColor = 0xFFFFFF
    cell = active_sheet.getCellRangeByName(addr_eps3)
    cell.CellBackColor = 0xFFFFFF

cell_stalk = active_sheet.getCellRangeByName(addr_stalk)
if ( out_of_spec ):
    cell_stalk.Value = 1
else:
    cell_stalk.String = ""
# @see ref: shorturl.at/lsuHT

olist = [ out_of_spec ]
print(olist)

sys.exit(0)

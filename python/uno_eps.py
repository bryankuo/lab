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
    eps21q4   = sys.argv[2]
    eps21q3   = sys.argv[3]
    eps21q2   = sys.argv[4]
    eps21q1   = sys.argv[5]
    eps20q4   = sys.argv[6]
    eps20q3   = sys.argv[7]
    eps20q2   = sys.argv[8]
    eps20q1   = sys.argv[9]
    eps19q4   = sys.argv[10]
    eps19q3   = sys.argv[11]
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

addr_q     = "J1" # initial
addr_x = "A1"

addr_2021q4 = "S1"
addr_2021q3 = "T1"
addr_2021q2 = "U1"
addr_2021q1 = "V1"

addr_2020q4 = "W1"
addr_2020q3 = "X1"
addr_2020q2 = "Y1"
addr_2020q1 = "Z1"

addr_2019q4 = "AA1"
addr_2019q3 = "AB1"
addr_2019q2 = "AC1"

addr_stalk = "AE1"

def set_value():
    cell_ticker = active_sheet.getCellRangeByName(addr_2021q4)
    cell_ticker.String = eps21q4
    cell_ticker = active_sheet.getCellRangeByName(addr_2021q3)
    cell_ticker.String = eps21q3
    cell_ticker = active_sheet.getCellRangeByName(addr_2021q2)
    cell_ticker.String = eps21q2
    cell_ticker = active_sheet.getCellRangeByName(addr_2021q1)
    cell_ticker.String = eps21q1
    cell_ticker = active_sheet.getCellRangeByName(addr_2020q4)
    cell_ticker.String = eps20q4
    cell_ticker = active_sheet.getCellRangeByName(addr_2020q3)
    cell_ticker.String = eps20q3
    cell_ticker = active_sheet.getCellRangeByName(addr_2020q2)
    cell_ticker.String = eps20q2
    cell_ticker = active_sheet.getCellRangeByName(addr_2020q1)
    cell_ticker.String = eps20q1
    cell_ticker = active_sheet.getCellRangeByName(addr_2019q4)
    cell_ticker.String = eps19q4
    cell_ticker = active_sheet.getCellRangeByName(addr_2019q3)
    cell_ticker.String = eps19q3

cellq = active_sheet.getCellRangeByName(addr_q)
for i in range(2, last_row):
    addr_x = "A" + str(i)
    cellx = active_sheet.getCellRangeByName(addr_x)
    if ( cellx.String == ticker ):
        addr_q = "J" + str(i)
        addr_2021q4 = "S" + str(i)
        addr_2021q3 = "T" + str(i)
        addr_2021q2 = "U" + str(i)
        addr_2021q1 = "V" + str(i)

        addr_2020q4 = "W" + str(i)
        addr_2020q3 = "X" + str(i)
        addr_2020q2 = "Y" + str(i)
        addr_2020q1 = "Z" + str(i)

        addr_2019q4 = "AA" + str(i)
        addr_2019q3 = "AB" + str(i)
        addr_2019q2 = "AC" + str(i)

        addr_stalk = "AE" + str(i)
        break

if ( addr_q == "J1" ):
    # print(ticker + corp_name + " not found in sheet, add entry,")
    addr_x = "A" + str( last_row + 1 )
    addr_2021q4 = "S" + str( last_row + 1 )
    addr_2021q3 = "T" + str( last_row + 1 )
    addr_2021q2 = "U" + str( last_row + 1 )
    addr_2021q1 = "V" + str( last_row + 1 )

    addr_2020q4 = "W" + str( last_row + 1 )
    addr_2020q3 = "X" + str( last_row + 1 )
    addr_2020q2 = "Y" + str( last_row + 1 )
    addr_2020q1 = "Z" + str( last_row + 1 )

    addr_2019q4 = "AA" + str( last_row + 1 )
    addr_2019q3 = "AB" + str( last_row + 1 )
    addr_2019q2 = "AC" + str( last_row + 1 )

    addr_stalk = "AE" + str( last_row + 1 )
    cell_ticker = active_sheet.getCellRangeByName(addr_x)
    cell_ticker.String = ticker

set_value()

out_of_spec = 0
if ( float(eps21q3) <= float(eps21q4) and
    float(eps21q2) <= float(eps21q3) ):
    out_of_spec = 1
    cell = active_sheet.getCellRangeByName(addr_2021q4)
    cell.CellBackColor = 0xFFFF00
    cell = active_sheet.getCellRangeByName(addr_2021q3)
    cell.CellBackColor = 0xFFFF00
    cell = active_sheet.getCellRangeByName(addr_2021q2)
    cell.CellBackColor = 0xFFFF00
else:
    cell = active_sheet.getCellRangeByName(addr_2021q4)
    cell.CellBackColor = 0xFFFFFF
    cell = active_sheet.getCellRangeByName(addr_2021q3)
    cell.CellBackColor = 0xFFFFFF
    cell = active_sheet.getCellRangeByName(addr_2021q2)
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

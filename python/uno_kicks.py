#!/usr/bin/python3

# looping:
# python3 uno_kicks.py [ticker] [quote]
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

# import socket  # only needed on win32-OOo3.0.0
import uno, sys, time
from datetime import datetime

# https://bit.ly/3sQRR4C
# import msgbox
# from pythonscript import ScriptContext

# /Applications/LibreOffice.app/Contents/Resources/python \
#   uno_kicks.py 1101 45.05

# /Applications/LibreOffice.app/Contents/Resources/python \
#   uno_kicks.py 1101 45.05 name qdi fund retail total
#                per ph52 pl52 peer

def context():
    # set global variables for context
    global desktop
    global model
    global active_sheet
    # get the doc from the scripting context
    # which is made available to all scripts
    desktop = XSCRIPTCONTEXT.getDesktop()
    model = desktop.getCurrentComponent()
    # access the active sheet
    active_sheet = model.CurrentController.ActiveSheet

MAX_ARG_LEN = 16
if ( len(sys.argv) >= MAX_ARG_LEN ):
    ticker = sys.argv[1]
    quote = sys.argv[2]
    corp_name = sys.argv[3]
    qdi       = sys.argv[4]
    fund      = sys.argv[5]
    retail    = sys.argv[6]
    d5total   = sys.argv[7]
    per       = sys.argv[8]
    per_hi52  = sys.argv[9]
    per_lo52  = sys.argv[10]
    per_peer  = sys.argv[11]
    r52l      = sys.argv[12]
    r52l_p    = sys.argv[13]
    r52h      = sys.argv[14]
    r52h_p    = sys.argv[15]
    cap_e     = sys.argv[16]
elif ( len(sys.argv) < MAX_ARG_LEN and len(sys.argv) >= 3 ):
    ticker = sys.argv[1]
    quote = sys.argv[2]
else:
    printf('illegal #')
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

# loop over existing rows @see shorturl.at/flzIR
# range/range source: @see shorturl.at/uwOWX
# oRangeSource = active_sheet.getCellRangeByName('A1:A10')
# print(oRangeSource.getDataArray())
#sys.exit(0)

# oSelection = model.getCurrentSelection()
# oArea = oSelection.getRangeAddress()
# store the attribute of CellRangeAddress
# nLeft = oArea.StartColumn
# nTop = oArea.StartRow
# nRight = oArea.EndColumn
# nBottom = oArea.EndRow
# print(str(nLeft) + ", " + str(nTop) + \
#     ", " + str(nRight) + ", " + str(nBottom))
# sys.exit(0)

# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)
# print(last_row)

'''
cursor = active_sheet.createCursor()
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
last_row = len(cursor.Rows)
sys.exit(0)
'''

addr_q     = "J1" # initial
addr_52lo  = "K1"
addr_r52lp = "L1"
addr_52hi  = "M1"
addr_r52hp = "N1"
addr_resist = "G1"
addr_support = "H1"
addr_cheap = "I1"
addr_x = "A1"
addr_n = "B1"
addr_qdi = "C1"
addr_fund = "D1"
addr_retail = "E1"
addr_5dtotal = "F1"
addr_per = "O1"
addr_per_h52 = "P1"
addr_per_l52 = "Q1"
addr_per_peer = "R1"

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
addr_2019q2     = "AC1"

addr_stalk      = "AE1"
addr_cape       = "AL1"

def set_value():
    if ( len(sys.argv) >= MAX_ARG_LEN ):
        cell_ticker = active_sheet.getCellRangeByName(addr_n)
        cell_ticker.String = corp_name
        cell_ticker = active_sheet.getCellRangeByName(addr_qdi)
        cell_ticker.String = qdi
        cell_ticker = active_sheet.getCellRangeByName(addr_fund)
        cell_ticker.String = fund
        cell_ticker = active_sheet.getCellRangeByName(addr_retail)
        cell_ticker.String = retail
        cell_ticker = active_sheet.getCellRangeByName(addr_5dtotal)
        cell_ticker.String = d5total
        cell_ticker = active_sheet.getCellRangeByName(addr_per)
        cell_ticker.String = per
        cell_ticker = active_sheet.getCellRangeByName(addr_per_h52)
        cell_ticker.String = per_hi52
        cell_ticker = active_sheet.getCellRangeByName(addr_per_l52)
        cell_ticker.String = per_lo52
        cell_ticker = active_sheet.getCellRangeByName(addr_per_peer)
        cell_ticker.String = per_peer
        cell_ticker = active_sheet.getCellRangeByName(addr_52lo)
        cell_ticker.String = r52l
        cell_ticker = active_sheet.getCellRangeByName(addr_r52lp)
        cell_ticker.String = r52l_p
        cell_ticker = active_sheet.getCellRangeByName(addr_52hi)
        cell_ticker.String = r52h
        cell_ticker = active_sheet.getCellRangeByName(addr_r52hp)
        cell_ticker.String = r52h_p
        cell_ticker = active_sheet.getCellRangeByName(addr_cape)
        cell_ticker.String = cap_e
'''
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
'''

cellq = active_sheet.getCellRangeByName(addr_q)
for i in range(2, last_row):
    addr_x = "A" + str(i)
    cellx = active_sheet.getCellRangeByName(addr_x)
    if ( cellx.String == ticker ):
        addr_q = "J" + str(i)
        addr_resist = "G" + str(i)
        addr_support = "H" + str(i)
        addr_cheap = "I" + str(i)
        addr_52lo = "K" + str(i)
        addr_r52lp = "L" + str(i)
        addr_52hi = "M" + str(i)
        addr_r52hp = "N" + str(i)
        addr_ticker = "A" + str(i)
        addr_n = "B" + str(i)
        addr_qdi = "C" + str(i)
        addr_fund = "D" + str(i)
        addr_retail = "E" + str(i)
        addr_5dtotal = "F" + str(i)
        addr_per = "O" + str(i)
        addr_per_h52 = "P" + str(i)
        addr_per_l52 = "Q" + str(i)
        addr_per_peer = "R" + str(i)
        addr_stalk = "AE" + str(i)
        addr_cape = "AL" + str(i)
        break

if ( addr_q == "J1" ):
    # print(ticker + corp_name + " not found in sheet, add entry,")
    addr_x = "A" + str( last_row + 1 )
    addr_n = "B" + str( last_row + 1 )
    addr_qdi = "C" + str( last_row + 1 )
    addr_fund = "D" + str( last_row + 1 )
    addr_retail = "E" + str( last_row + 1 )
    addr_5dtotal = "F" + str( last_row + 1 )
    addr_q = "J" + str( last_row + 1 )
    addr_resist = "G" + str( last_row + 1 )
    addr_support = "H" + str( last_row + 1 )
    addr_cheap = "I" + str( last_row + 1 )
    addr_52lo = "K" + str( last_row + 1 )
    addr_r52lp = "L" + str( last_row + 1 )
    addr_52hi = "M" + str( last_row + 1 )
    addr_r52hp = "N" + str( last_row + 1 )
    addr_per = "O" + str( last_row + 1 )
    addr_per_h52 = "P" + str( last_row + 1 )
    addr_per_l52 = "Q" + str( last_row + 1 )
    addr_per_peer = "R" + str( last_row + 1 )
    addr_stalk = "AE" + str( last_row + 1 )
    addr_cape     = "AL" + str( last_row + 1 )
    cell_ticker = active_sheet.getCellRangeByName(addr_x)
    cell_ticker.String = ticker

set_value()

cellq = active_sheet.getCellRangeByName(addr_q)
cellq.String = quote
cellq.CellBackColor = 0xFFFF00
time.sleep(.6)
cellq.CellBackColor = 0xFFFFFF
out_of_spec = 0

cell   = active_sheet.getCellRangeByName(addr_support)
cell_r = active_sheet.getCellRangeByName(addr_resist)
# @see https://stackoverflow.com/a/9573283
if ( cell.String and cell.String != "n/a" and cell.String != "" ):
    support = float(cell.String)
    if ( support > float(quote) ):
        cell_r.String = support
        cell_r.CellBackColor = 0xFFFF00
        cell.String = ""
        cell.CellBackColor = 0xFFFFFF
        out_of_spec = 1 # become resistance

if ( cell_r.String and cell_r.String != "n/a" and cell_r.String != "" ):
    resist = float(cell_r.String)
    if ( resist < float(quote) ):
        cell.String = resist
        cell.CellBackColor = 0xFFFF00
        cell_r.String = ""
        cell_r.CellBackColor = 0xFFFFFF
        out_of_spec = 1 # become support

cell = active_sheet.getCellRangeByName(addr_52lo)
if ( cell.String and cell.String != "n/a" ):
    if ( float(cell.String) > float(quote) ):
        cell.CellBackColor = 0xFFFF00
        out_of_spec = 1
    else:
        cell.CellBackColor = 0xFFFFFF

cell = active_sheet.getCellRangeByName(addr_cheap)
if ( cell.String and cell.String != "n/a" ):
    if ( float(cell.String) > float(quote) ):
        cell.CellBackColor = 0xFFFF00
        out_of_spec = 1
    else:
        cell.CellBackColor = 0xFFFFFF

cell = active_sheet.getCellRangeByName(addr_52hi)
if ( cell.String and cell.String != "n/a" ):
    if ( float(cell.String) < float(quote) ):
        cell.CellBackColor = 0xFFFF00
        out_of_spec = 1
    else:
        cell.CellBackColor = 0xFFFFFF

# cell_name   = active_sheet.getCellRangeByName(addr_n)
# color_name = cell_name.CellBackColor
# cell_ticker = active_sheet.getCellRangeByName(addr_x)
# color_ticker = cell_ticker.CellBackColor

# if out of spec or marking as 'watching' then set 'stalking' to 1 else 0
# if ( color_name != 0xFFFFFF ):
# cell_stalk.Value= 1

cell_stalk = active_sheet.getCellRangeByName(addr_stalk)
if ( out_of_spec ):
    cell_stalk.Value = 1
else:
    cell_stalk.String = ""
# @see ref: shorturl.at/lsuHT

olist = [ out_of_spec ]
print(olist)

# //TODO: multithreading

# //TODO: support and resistance
# @see https://www.cnyes.com/twstock/Pressure24.aspx?code=1258
# 24d, type 2, 4
# @see https://www.capital.com.tw/stock/fetw/sup_res.asp
# https://www.capital.com.tw/stock/fetw/sup_res.asp?xy=4&xt=6
# @see https://www.wantgoo.com/stock/future-index-calculator

sys.exit(0)

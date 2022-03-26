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

MAX_ARG_LEN = 15
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
elif ( len(sys.argv) < MAX_ARG_LEN and len(sys.argv) >= 3 ):
    ticker = sys.argv[1]
    quote = sys.argv[2]
else:
    printf('illegal #')
    sys.exit(0)

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
last_row = len(cursor.Rows)
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
addr_stalk = "AE1"

def set_info():
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
        cell_ticker = active_sheet.getCellRangeByName(addr_52lo)
        cell_ticker.String = r52l
        cell_ticker = active_sheet.getCellRangeByName(addr_r52lp)
        cell_ticker.String = r52l_p
        cell_ticker = active_sheet.getCellRangeByName(addr_52hi)
        cell_ticker.String = r52h
        cell_ticker = active_sheet.getCellRangeByName(addr_r52hp)
        cell_ticker.String = r52h_p

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
        addr_r52lp = "L"+str(i+1)
        addr_52hi = "M"+str(i+1)
        addr_r52hp = "N"+str(i+1)
        addr_ticker = "A" + str(i+1)
        addr_n = "B" + str(i+1)
        addr_qdi = "C" + str(i+1)
        addr_fund = "D" + str(i+1)
        addr_retail = "E" + str(i+1)
        addr_5dtotal = "F" + str(i+1)
        addr_per = "O" + str(i+1)
        addr_stalk = "AE" + str(i+1)
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
    addr_stalk = "AE" + str( last_row + 1 )
    cell_ticker = active_sheet.getCellRangeByName(addr_x)
    cell_ticker.String = ticker
    # set_info()
    '''
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
        cell_ticker = active_sheet.getCellRangeByName(addr_52lo)
        cell_ticker.String = r52l
        cell_ticker = active_sheet.getCellRangeByName(addr_r52lp)
        cell_ticker.String = r52l_p
        cell_ticker = active_sheet.getCellRangeByName(addr_52hi)
        cell_ticker.String = r52h
        cell_ticker = active_sheet.getCellRangeByName(addr_r52hp)
        cell_ticker.String = r52h_p

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
    cell_ticker = active_sheet.getCellRangeByName(addr_52lo)
    cell_ticker.String = r52l
    cell_ticker = active_sheet.getCellRangeByName(addr_r52lp)
    cell_ticker.String = r52l_p
    cell_ticker = active_sheet.getCellRangeByName(addr_52hi)
    cell_ticker.String = r52h
    cell_ticker = active_sheet.getCellRangeByName(addr_r52hp)
    cell_ticker.String = r52h_p
'''
set_info()

cellq = active_sheet.getCellRangeByName(addr_q)
cellq.String = quote
cellq.CellBackColor = 0xFFFF00
time.sleep(.7)
cellq.CellBackColor = 0xFFFFFF
out_of_spec = 0

cell = active_sheet.getCellRangeByName(addr_support)
# @see https://stackoverflow.com/a/9573283
if ( cell.String and cell.String != "n/a" ):
    if ( cell.Value >= float(quote) ):
        cell = active_sheet.getCellRangeByName(addr_support)
        cell.CellBackColor = 0xFFFF00
        out_of_spec = 1
    else:
        cell.CellBackColor = 0xFFFFFF

cell = active_sheet.getCellRangeByName(addr_52lo)
if ( cell.String and cell.String != "n/a" ):
    if ( cell.Value > float(quote) ):
        cell = active_sheet.getCellRangeByName(addr_52lo)
        cell.CellBackColor = 0xFFFF00
        cell.String = quote
        out_of_spec = 1
    else:
        cell.CellBackColor = 0xFFFFFF

cell = active_sheet.getCellRangeByName(addr_cheap)
if ( cell.String and cell.String != "n/a" ):
    if ( cell.Value > float(quote) ):
        cell = active_sheet.getCellRangeByName(addr_cheap)
        cell.CellBackColor = 0xFFFF00
        out_of_spec = 1
    else:
        cell.CellBackColor = 0xFFFFFF

cell = active_sheet.getCellRangeByName(addr_resist)
if ( cell.String and cell.String != "n/a" ):
    if ( cell.Value < float(quote) ):
        cell = active_sheet.getCellRangeByName(addr_resist)
        cell.CellBackColor = 0xFFFF00
        out_of_spec = 1
    else:
        cell.CellBackColor = 0xFFFFFF

cell = active_sheet.getCellRangeByName(addr_52hi)
if ( cell.String and cell.String != "n/a" ):
    if ( cell.Value < float(quote) ):
        cell = active_sheet.getCellRangeByName(addr_52hi)
        cell.CellBackColor = 0xFFFF00
        cell.String = quote
        out_of_spec = 1
    else:
        cell.CellBackColor = 0xFFFFFF

cell_name   = active_sheet.getCellRangeByName(addr_n)
color_name = cell_name.CellBackColor
cell_ticker = active_sheet.getCellRangeByName(addr_x)
color_ticker = cell_ticker.CellBackColor
'''
// TODO:
cell_stalk = active_sheet.getCellRangeByName(addr_stalk)
cell_stalk.String = ""
if ( color_name != 0xFFFFFF ):
    cell_stalk.Value= 1
# @see https://wiki.openoffice.org/w/images/d/d9/DevelopersGuide_OOo3.1.0.pdf
'''

olist = [ out_of_spec, color_name, color_ticker ]
print(olist)

# //TODO: multithreading

# //TODO: support and resistance
# @see https://www.cnyes.com/twstock/Pressure24.aspx?code=1258
# 24d, type 2, 4
# @see https://www.capital.com.tw/stock/fetw/sup_res.asp
# https://www.capital.com.tw/stock/fetw/sup_res.asp?xy=4&xt=6
# @see https://www.wantgoo.com/stock/future-index-calculator

sys.exit(0)

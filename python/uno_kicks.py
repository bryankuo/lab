#!/usr/bin/python3

# python3 uno_kicks.py [ticker] [quote]
# return a list to caller

# calc uno playground

# reference doc:
# shorturl.at/EIJV1
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

# import socket  # only needed on win32-OOo3.0.0
import uno, sys, time
from datetime import datetime
from com.sun.star.uno import RuntimeException

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
    global sheet0
    # get the doc from the scripting context
    # which is made available to all scripts
    desktop = XSCRIPTCONTEXT.getDesktop()
    model = desktop.getCurrentComponent()
    sheet0 = model.Sheets.getByName("20231211")

MAX_ARG_LEN = 22
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
    sma5      = sys.argv[17]
    sma5_d    = sys.argv[18] # direction is TBD
    sma20     = sys.argv[19]
    sma20_d   = sys.argv[20]
    sma60     = sys.argv[21]
    sma60_d   = sys.argv[22]
elif ( len(sys.argv) < MAX_ARG_LEN and len(sys.argv) >= 3 ):
    ticker = sys.argv[1]
    quote = sys.argv[2]
else:
    print('illegal #')
    sys.exit(0)

# try:
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
# sheet_name = "20231211"
# sheet = model.Sheets.getByName(sheet_name)
# model.getCurrentController.setActiveSheet(sheet) # set the sheet active

# access the active sheet
# sheet0 = model.CurrentController.ActiveSheet
sheet0 = model.Sheets.getByName("20231211")

# access cell C4
# cell1 = sheet0.getCellRangeByName("j501")

# set text inside
# cell1.String = ticker # "28.42" # "Hello world"
# cell1.CellBackColor=0xFF0000 # (red)

# other example with a value
# cell2 = sheet0.getCellRangeByName("E6")
# cell2.Value = cell2.Value + 1

# loop over existing rows @see shorturl.at/flzIR
# range/range source: @see shorturl.at/uwOWX
# oRangeSource = sheet0.getCellRangeByName('A1:A10')
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
guessRange = sheet0.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = sheet0.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = sheet0.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)
# print(last_row)

'''
cursor = sheet0.createCursor()
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
last_row = len(cursor.Rows)
sys.exit(0)
'''

# set number format. is ( model, doc ) interchangable in terms?
doc = None
numbers = None
locale = None
nl = None
# trying:
# @see https://ask.libreoffice.org/t/why-does-desktop-getcurrentcomponent-return-none-in-pyuno/59902/5
while doc is None:
    doc = desktop.getCurrentComponent()
    numbers = doc.NumberFormats
    locale = doc.CharLocale
# instead of
# @see https://ask.libreoffice.org/t/formatting-data-cell-from-macro-in-calc/23740
# doc = XSCRIPTCONTEXT.getDocument()
try:
    nl = numbers.addNew( "###0.00",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0.00", locale, False)

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

# caller uno_eps.sh, uno_status.sh -> uno_eps.py
# addr_2021q4 = "S1"
# addr_2021q3 = "T1"
# addr_2021q2 = "U1"
# addr_2021q1 = "V1"

# addr_2020q4 = "W1"
# addr_2020q3 = "X1"
# addr_2020q2 = "Y1"
# addr_2020q1 = "Z1"

# addr_2019q4 = "AA1"
# addr_2019q3 = "AB1"
# addr_2019q2     = "AC1"

addr_stalk      = "AE1"
addr_cape       = "AL1"

addr_sma5       = "AN1"
addr_sma20      = "AO1"
addr_sma60      = "AP1"
addr_last       = "BH1"

def set_value():
    if ( len(sys.argv) >= MAX_ARG_LEN ):
        cell_ticker = sheet0.getCellRangeByName(addr_n)
        cell_ticker.String = corp_name
        cell_ticker = sheet0.getCellRangeByName(addr_qdi)
        cell_ticker.Value = int(qdi)
        cell_ticker = sheet0.getCellRangeByName(addr_fund)
        cell_ticker.Value = int(fund)
        cell_ticker = sheet0.getCellRangeByName(addr_retail)
        cell_ticker.Value = int(retail)
        cell_ticker = sheet0.getCellRangeByName(addr_5dtotal)
        cell_ticker.String = d5total
        cell_ticker = sheet0.getCellRangeByName(addr_per)
        cell_ticker.String = per
        cell_ticker = sheet0.getCellRangeByName(addr_per_h52)
        cell_ticker.String = per_hi52
        cell_ticker = sheet0.getCellRangeByName(addr_per_l52)
        cell_ticker.String = per_lo52
        cell_ticker = sheet0.getCellRangeByName(addr_per_peer)
        cell_ticker.String = per_peer
        cell_ticker = sheet0.getCellRangeByName(addr_52lo)
        cell_ticker.String = r52l
        cell_ticker = sheet0.getCellRangeByName(addr_r52lp)
        cell_ticker.String = r52l_p
        cell_ticker = sheet0.getCellRangeByName(addr_52hi)
        cell_ticker.String = r52h
        cell_ticker = sheet0.getCellRangeByName(addr_r52hp)
        cell_ticker.String = r52h_p
        cell_ticker = sheet0.getCellRangeByName(addr_cape)
        cell_ticker.Value = float(cap_e)
        cell_ticker = sheet0.getCellRangeByName(addr_sma5)
        cell_ticker.Value = float(sma5)
        cell_ticker = sheet0.getCellRangeByName(addr_sma20)
        cell_ticker.Value = float(sma20)
        cell_ticker = sheet0.getCellRangeByName(addr_sma60)
        cell_ticker.Value = float(sma60)

cellq = sheet0.getCellRangeByName(addr_q)
for i in range(2, last_row):
    addr_x = "A" + str(i)
    cellx = sheet0.getCellRangeByName(addr_x)
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
        addr_sma5     = "AN" + str(i)
        addr_sma20    = "AO" + str(i)
        addr_sma60    = "AP" + str(i)
        addr_last     = "BH" + str(i)
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
    addr_sma5     = "AN" + str( last_row + 1 )
    addr_sma20    = "AO" + str( last_row + 1 )
    addr_sma60    = "AP" + str( last_row + 1 )
    addr_last     = "BH" + str( last_row + 1 )
    cell_ticker = sheet0.getCellRangeByName(addr_x)
    cell_ticker.String = ticker

set_value()

cellq = sheet0.getCellRangeByName(addr_q)
cellq.Value = float(quote)
cellq.NumberFormat = nl
cellq.CellBackColor = 0xFFFF00
time.sleep(.6)
cellq.CellBackColor = 0xFFFFFF
out_of_spec = 0

cell   = sheet0.getCellRangeByName(addr_support)
cell_r = sheet0.getCellRangeByName(addr_resist)
# @see https://stackoverflow.com/a/9573283
if ( cell.String and cell.String != "n/a" and cell.String != "" ):
    support = float(cell.String)
    if ( support > float(quote) ):
        cell_r.String = support
        cell_r.CellBackColor = 0xFFFF00
        cell.String = ""
        # cell.CellBackColor = 0xFFFFFF
        out_of_spec = out_of_spec + 1 # become resistance

if ( cell_r.String and cell_r.String != "n/a" and cell_r.String != "" ):
    resist = float(cell_r.String)
    if ( resist < float(quote) ):
        cell.String = resist
        # cell.CellBackColor = 0xFFFF00
        cell_r.String = ""
        cell_r.CellBackColor = 0xFFFFFF
        out_of_spec = out_of_spec + 2 # become support

cell = sheet0.getCellRangeByName(addr_52lo)
if ( cell.String and cell.String != "n/a" ):
    if ( float(cell.String) > float(quote) ):
        cell.CellBackColor = 0xFFFF00
        out_of_spec = out_of_spec + 4
    else:
        cell.CellBackColor = 0xFFFFFF

cell = sheet0.getCellRangeByName(addr_cheap)
if ( cell.String and cell.String != "n/a" ):
    if ( float(cell.String) > float(quote) ):
        cell.CellBackColor = 0xFFFF00
        out_of_spec = out_of_spec + 8
    else:
        cell.CellBackColor = 0xFFFFFF

cell = sheet0.getCellRangeByName(addr_52hi)
if ( cell.String and cell.String != "n/a" ):
    if ( float(cell.String) < float(quote) ):
        cell.CellBackColor = 0xFFFF00
        out_of_spec = out_of_spec + 16
    else:
        cell.CellBackColor = 0xFFFFFF

# cell_name   = sheet0.getCellRangeByName(addr_n)
# color_name = cell_name.CellBackColor
# cell_ticker = sheet0.getCellRangeByName(addr_x)
# color_ticker = cell_ticker.CellBackColor

# if out of spec or marking as 'watching' then set 'stalking' to 1 else 0
# if ( color_name != 0xFFFFFF ):
# cell_stalk.Value= 1

cell_stalk = sheet0.getCellRangeByName(addr_stalk)
if ( 0 < out_of_spec ):
    cell_stalk.Value = 1
else:
    cell_stalk.String = ""
# @see ref: shorturl.at/lsuHT

cell = sheet0.getCellRangeByName(addr_last)
cell.Value = int('{:%Y%m%d}'.format(datetime.now()))

olist = [ out_of_spec ]
print(olist)

# //TODO: multithreading

# //TODO: support and resistance
# @see https://www.cnyes.com/twstock/Pressure24.aspx?code=1258
# 24d, type 2, 4
# @see https://www.capital.com.tw/stock/fetw/sup_res.asp
# https://www.capital.com.tw/stock/fetw/sup_res.asp?xy=4&xt=6
# @see https://www.wantgoo.com/stock/future-index-calculator

'''
// TODO: to dig more @see https://selenium-python.readthedocs.io/api.html
except NoConnectException e:
    print "The OpenOffice.org process is not started or does not listen on the resource ("+e.Message+")"
except IllegalArgumentException e:
    print "The url is invalid ( "+ e.Message+ ")"
except RuntimeException e:
    print "An unknown error occurred: " + e.Message
except NoConnectException as ex:
    print(ex.Message)
    print('make sure calc UNO bridge is ready.')
finally:
'''
sys.exit(0)

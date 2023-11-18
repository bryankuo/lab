#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_formula.py [file]
#
# calc uno playground
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

import uno, sys, time, os
from datetime import datetime
from com.sun.star.uno import RuntimeException
# from datetime import date

yyyymmdd = sys.argv[1]
sheet_name = "rs."+yyyymmdd
# print(sheet_name)

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
active_sheet = model.Sheets.getByName(sheet_name)

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
    nl = numbers.addNew( "###0.000",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0.000", locale, False)

# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)
n_ticker = ( last_row - 2 ) + 1

# import os
# duration = 1  # seconds
# freq = 440  # Hz
# os.system('play -nq -t alsa synth {} sine {}'.format(duration, freq))
# sys.exit(0)

DIR0="./datafiles/taiex/rs"
# theday = datetime.today().strftime('%Y%m%d')
fname0 = "pr34above75." + yyyymmdd + '.csv'
path0 = os.path.join(DIR0, fname0)
outf0 = open(path0, "w")
outf0.write("ticker:pr1w:pr1m\n")

fname1 = "leading75." + yyyymmdd + '.csv'
path1 = os.path.join(DIR0, fname1)
outf1 = open(path1, "w")
outf1.write("ticker:pr1w:pr1m:pr3m:ytd\n")

def set_formula_1w():
    addr = "$L1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(1w)"
    # msgbox(cell.AbsoluteName)
    # cell.String = "a1b2c3"
    # cell_stalk.Value = 1
    # cell.Formula = "=C2+D2"
    for i in range( 2, last_row + 1 ):
        addr = "L"+str(i)
        cell = active_sheet.getCellRangeByName(addr)
        f = "=PERCENTRANK($D2:$D$"+str(last_row)+"; $D"+str(i)+")"
        cell.Formula = f
        cell.NumberFormat = nl
        if ( 0.66 < cell.Value ):
            cell.CellBackColor = 0x3faf46

        addr_1m = "M"+str(i)
        cell_1m = active_sheet.getCellRangeByName(addr_1m)
        if ( cell_1m.Value < 0.34 and 0.75 < cell.Value ):
            cell.CellBackColor = 0xffff38
            tkr = active_sheet.getCellRangeByName("A"+str(i)).String
            outf0.write(tkr + ":" \
                + "{:3.3f}".format(cell.Value) + ":" \
                + "{:3.3f}".format(cell_1m.Value) + "\n")

        rs_1w  = active_sheet.getCellRangeByName("L"+str(i)).Value
        rs_1m  = active_sheet.getCellRangeByName("M"+str(i)).Value
        rs_3m  = active_sheet.getCellRangeByName("N"+str(i)).Value
        rs_ytd = active_sheet.getCellRangeByName("O"+str(i)).Value
        if ( 0.75 < rs_1w and 0.75 < rs_1m and 0.75 < rs_3m and 0.75 < rs_ytd ):
            tkr = active_sheet.getCellRangeByName("A"+str(i)).String
            outf1.write(tkr + ":" \
                + "{:3.3f}".format(rs_1w) + ":" \
                + "{:3.3f}".format(rs_1m) + ":" \
                + "{:3.3f}".format(rs_3m) + ":" \
                + "{:3.3f}".format(rs_ytd) + "\n")

def set_formula_1m():
    addr = "$M1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(1m)"
    for i in range( 2, last_row + 1 ):
        addr = "M"+str(i)
        cell = active_sheet.getCellRangeByName(addr)
        f = "=PERCENTRANK($E2:$E"+str(last_row)+"; $E"+str(i)+")"
        cell.Formula = f
        cell.NumberFormat = nl
        if ( 0.66 < cell.Value ):
            cell.CellBackColor = 0x3faf46

            # set cell border
            aThinBorder = cell.TopBorder2
            aThinBorder.Color          = 0x00ff0000
            aThinBorder.LineWidth      = 1
            aThinBorder.InnerLineWidth = 0
            aThinBorder.OuterLineWidth = 1
            cell.LeftBorder2   = aThinBorder

            rThinBorder = cell.RightBorder2
            rThinBorder.Color = 0x0000ff00
            rThinBorder.LineWidth = 5
            aThinBorder.InnerLineWidth = 0
            aThinBorder.OuterLineWidth = 1
            cell.RightBorder2   = rThinBorder
            cell.BottomBorder2 = rThinBorder
            cell.TopBorder2 = rThinBorder
            # // TODO: playground
            # @see https://t.ly/TFSjH
            # @see https://t.ly/_wZ6_
            # @see https://t.ly/UR2Us
            #aThinBorder.LineDistance   = 0
            # aThinBorder.LineStyle      = 1

def set_formula_3m():
    addr = "$n1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(3m)"
    for i in range( 2, last_row + 1 ):
        addr = "N"+str(i)
        cell = active_sheet.getCellRangeByName(addr)
        f = "=PERCENTRANK($G2:$G"+str(last_row)+"; $G"+str(i)+")"
        cell.Formula = f
        cell.NumberFormat = nl
        if ( 0.75 < cell.Value ):
            cell.CellBackColor = 0x3faf46

def set_formula_ytd():
    addr = "$O1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(ytd)"
    for i in range( 2, last_row + 1 ):
        addr = "$O"+str(i)
        cell = active_sheet.getCellRangeByName(addr)
        f = "=PERCENTRANK($J2:$J"+str(last_row)+"; $J"+str(i)+")"
        cell.Formula = f
        cell.NumberFormat = nl
        if ( 0.75 < cell.Value ):
            cell.CellBackColor = 0x3faf46

def draw_legend():
    addr = "$P1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "Legend"

    addr = "$P2"
    cell = active_sheet.getCellRangeByName(addr)
    cell.CellBackColor = 0x3faf46

    addr = "$Q2"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR75 or leading one-4th"

    addr = "$P3"
    cell = active_sheet.getCellRangeByName(addr)
    cell.CellBackColor = 0xffff38

    addr = "$Q3"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "Advancing from below PR33 to leading PR75"


set_formula_ytd()
set_formula_3m()
set_formula_1m()
set_formula_1w()
draw_legend()

outf0.close(); outf1.close()

olist = [ str(last_row), path0 ]
print(olist)
print("\a")

sys.exit(0)

# ls -lt datafiles/taiex/rs/*.csv | head -n 5
#

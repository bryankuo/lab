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
# test
from com.sun.star.awt import MessageBoxButtons as MSG_BUTTONS

yyyymmdd = sys.argv[1]
s0 = "rs."+yyyymmdd
s1 = "leading75"
s2 = "pr34above75"

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

doc.Sheets.insertNewByName(s1, 1)
doc.Sheets.insertNewByName(s2, 2)
active_sheet = doc.Sheets.getByName(s0)

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

# rule 1
fname1 = "leading75." + yyyymmdd + '.csv'
path1 = os.path.join(DIR0, fname1)
outf1 = open(path1, "w")
outf1.write("ticker:pr1w:pr1m:pr3m:ytd\n")

'''
# ====test
# https://api.libreoffice.org/docs/idl/ref/namespacecom_1_1sun_1_1star_1_1sheet.html
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets#Sheets
# active_sheet = doc.Sheets.getByIndex(1) # works
# sname = "strategies"
# sname = "Sheet7"
# active_sheet = doc.Sheets.getByName(sname) # works
# https://forum.openoffice.org/en/forum/viewtopic.php?p=371055#p371055
# doc.CurrentController.setActiveSheet(active_sheet) # works
# Controller = doc.getcurrentController
# Controller.setActiveSheet(active_sheet)
# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 0, 6, 30) # works
# look up the actual used area within the guess area
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
# guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows), 1)
# print(guessRange.getDataArray()) # works
last_row = len(cursor.Rows)
# print("cursor row "+ str(last_row))
# print("# sheets: " + str(doc.Sheets.Count)) # works
# sheet = doc.Sheets.getByIndex(3)
# sheet.Name = 'OtherName其他名字'
# doc.CurrentController.setActiveSheet(sheet) # works
# @see https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets#Insert
# doc.Sheets.insertNewByName('leading75', 1) # works
# doc.Sheets.moveByName('leading75', 1)
# doc.Sheets.insertNewByName('pr34above75', 2) # works
# // TODO: how to remove a sheet?
'''

# rule 2
fname0 = "pr34above75." + yyyymmdd + '.csv'
path0 = os.path.join(DIR0, fname0)
outf0 = open(path0, "w")
outf0.write("ticker:pr1w:pr1m\n")

sheet1 = doc.Sheets.getByName(s1)

def check_rule_1(row_idx):
    i = row_idx
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

        range1 = sheet1.getCellRangeByPosition(0, 0, 4, 999) # topl, bottomr
        cursor1 = sheet1.createCursorByRange(range1)
        cursor1.gotoEndOfUsedArea(False)
        cursor1.gotoStartOfUsedArea(True)
        new_row = len(cursor1.Rows) + 1

        # // TODO: format
        sheet1.getCellRangeByName("A"+str(new_row)).String  = tkr
        sheet1.getCellRangeByName("b"+str(new_row)).String  = rs_1w
        sheet1.getCellRangeByName("c"+str(new_row)).String  = rs_1m
        sheet1.getCellRangeByName("$d"+str(new_row)).String = rs_ytd

def check_rule_2(row_idx):
    i = row_idx
    cell   = active_sheet.getCellRangeByName("L"+str(i))
    rs_1w  = active_sheet.getCellRangeByName("L"+str(i)).Value
    rs_1m  = active_sheet.getCellRangeByName("M"+str(i)).Value
    rs_3m  = active_sheet.getCellRangeByName("N"+str(i)).Value
    rs_ytd = active_sheet.getCellRangeByName("O"+str(i)).Value

    # straigh 3 at December seems all losers
    # if ( rs_3m < 0.34 and rs_1m < 0.34 \
    #     and 0.75 < cell.Value ):

    if ( rs_1m < 0.34 and 0.75 < rs_1w ):
        cell.CellBackColor = 0xffff38
        tkr = active_sheet.getCellRangeByName("A"+str(i)).String
        outf0.write(tkr + ":" \
            + "{:3.3f}".format(rs_1w) + ":" \
            + "{:3.3f}".format(rs_1m) + ":" \
            + "{:3.3f}".format(rs_3m) + "\n")
        # // TODO: fill it up to sheet2

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
        check_rule_1(i)
        check_rule_2(i)
        # // TODO:

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
    active_sheet = doc.Sheets.getByName(s0)
    addr = "$P1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "Legend"

    addr = "$P2"
    cell = active_sheet.getCellRangeByName(addr)
    cell.CellBackColor = 0x3faf46

    addr = "$Q2"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "straight 4 PR75 or leading one-4th"

    addr = "$P3"
    cell = active_sheet.getCellRangeByName(addr)
    cell.CellBackColor = 0xffff38

    addr = "$Q3"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "3m, 1m below PR33 to 1w leading PR75"

    sheet1 = doc.Sheets.getByName(s1)
    sheet1.getCellRangeByName("A1").String = "ticker"
    sheet1.getCellRangeByName("b1").String = "pr1w"
    sheet1.getCellRangeByName("c1").String = "pr1m"
    sheet1.getCellRangeByName("$d1").String = "pr3m"
    range1 = sheet1.getCellRangeByPosition(0, 0, 4, 999) # topl, bottomr
    cursor1 = sheet1.createCursorByRange(range1)
    cursor1.gotoEndOfUsedArea(False)
    cursor1.gotoStartOfUsedArea(True)
    print("# row: "+str(len(cursor1.Rows)))

    sheet2 = doc.Sheets.getByName(s2)
    sheet2.getCellRangeByName("A1").String = "ticker"
    sheet2.getCellRangeByName("b1").String = "pr1w"
    sheet2.getCellRangeByName("c1").String = "pr1m"
    sheet2.getCellRangeByName("$d1").String = "pr3m"
    sheet2.getCellRangeByName("$E1").String = "ytd"
    range2 = sheet2.getCellRangeByPosition(0, 0, 5, 999) # topl, bottomr
    cursor2 = sheet2.createCursorByRange(range2)
    cursor2.gotoEndOfUsedArea(False)
    cursor2.gotoStartOfUsedArea(True)
    print("2 # row: "+str(len(cursor2.Rows)))

    # doc.CurrentController.setActiveSheet(sheet0)
    active_sheet = doc.Sheets.getByName(s0)
    # // TODO: dispathing call to a1

draw_legend()
set_formula_ytd()
set_formula_3m()
set_formula_1m()
set_formula_1w()
doc.store()
outf0.close(); outf1.close()

olist = [ last_row, path0, path1 ]
print(olist)

sys.exit(0)

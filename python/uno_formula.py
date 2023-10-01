#!/usr/bin/python3

# /Applications/LibreOffice.app/Contents/Resources/python
#  uno_formula.py [file]
#
# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

import uno, sys, time
from datetime import datetime

file_name = sys.argv[1]
# assume ror.20231001.ods, sheet name : 'ror.20231001'
tokens = file_name.split('.')
sheet_name = tokens[0]+"."+tokens[1]
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

# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
last_row = len(cursor.Rows)

def set_formula_1w():
    addr = "$L1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(1w)"

    addr_x = "L2"
    cell = active_sheet.getCellRangeByName(addr_x)
    # cell.String = "a1b2c3"
    # cell_stalk.Value = 1
    # cell.Formula = "=C2+D2"
    cell.Formula = "=PERCENTRANK($D$2:$D$6; $D2)"

    addr_x = "L3"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($D$2:$D$6; $D3)"

    addr_x = "L4"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($D$2:$D$6; $D4)"

    addr_x = "L5"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($D$2:$D$6; $D5)"

    addr_x = "L6"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($D$2:$D$6; $D6)"

def set_formula_1m():
    addr = "$M1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(1m)"

    addr_x = "M2"
    cell = active_sheet.getCellRangeByName(addr_x)
    # cell.String = "a1b2c3"
    # cell_stalk.Value = 1
    # cell.Formula = "=C2+D2"
    cell.Formula = "=PERCENTRANK($E$2:$E$6; $E2)"

    addr_x = "M3"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($E$2:$E$6; $E3)"

    addr_x = "M4"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($E$2:$E$6; $E4)"

    addr_x = "M5"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($E$2:$E$6; $E5)"

    addr_x = "M6"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($E$2:$E$6; $E6)"

def set_formula_3m():
    addr = "$N1"
    cell = active_sheet.getCellRangeByName(addr)
    cell.String = "PR(3m)"

    addr_x = "n2"
    cell = active_sheet.getCellRangeByName(addr_x)
    # cell.String = "a1b2c3"
    # cell_stalk.Value = 1
    # cell.Formula = "=C2+D2"
    cell.Formula = "=PERCENTRANK($G$2:$G$6; $G2)"

    addr_x = "N3"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($G$2:$G$6; $G3)"

    addr_x = "N4"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($G$2:$G$6; $G4)"

    addr_x = "N5"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($G$2:$G$6; $G5)"

    addr_x = "N6"
    cell = active_sheet.getCellRangeByName(addr_x)
    cell.Formula = "=PERCENTRANK($G$2:$G$6; $G6)"

set_formula_1w()
set_formula_1m()
set_formula_3m()

olist = [ str(last_row) ]
print(olist)

sys.exit(0)

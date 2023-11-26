#!/usr/bin/python3

# batch update quote to calc
# \param in after market csv
# \param activity watchlist ods
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
DIR0="./datafiles/taiex/after.market"
fname0 = yyyymmdd + '.csv'
path0 = os.path.join(DIR0, fname0)

sheet_name = "20220126"
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
    nl = numbers.addNew( "###0.00",  locale )
except RuntimeException:
    nl = numbers.queryKey("###0.00", locale, False)

FLEN = "$BI1"
LROW = "$BJ1"
FIDX = "$Bk1" # in calc, case insensitive
TIKR = "$BL1"
POS  = "$BM1"
UPTD = "$BH"

# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = active_sheet.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
n_ticker = len(cursor.Rows) - 1
cell4 = active_sheet.getCellRangeByName(LROW)
cell4.Value = len(cursor.Rows)

# theday = datetime.today().strftime('%Y%m%d')
infile0 = open(path0, "r")
ilist = infile0.readlines()
# print( "# ilist: " + str(len(ilist)) ) # // FIXME: no console output


cell5 = active_sheet.getCellRangeByName(FLEN)
cell5.Value = len(ilist)

# cell = active_sheet.getCellRangeByName("$BI1")
# print( str(cell.getCellAddress().Column) + ", " + str(cell.getCellAddress().Row) )
# print( cell.getCellAddress().Sheet )
# print( cell.getCellAddress() )
# print( cell.Formula )
# cell.Value = len(doc.getSheets()) # OK
columns = active_sheet.getColumns()
# cell.Value = len( columns )
column = columns.getByName("B")
column.Width = 6000 # works .7875" = 2000

# @see https://stackoverflow.com/a/72261886
# second_doc = desktop.create_spreadsheet() # testing

try:
    index = 2
    cell6 = active_sheet.getCellRangeByName(FIDX)
    cell6.Value = index
    for l in ilist:
        # cursor.gotoStartOfUsedArea(True) # testing
        the_line = l.replace('\n','')
        items = the_line.split(":")
        tkr   = items[0].strip()
        close = items[1]
        cell0 = active_sheet.getCellRangeByName(TIKR)
        cell0.Value = tkr
        tkr_found = False
        for i in range( 2, len(cursor.Rows)+1 ): # to be verified
            cell7 = active_sheet.getCellRangeByName("$A"+str(i))
            if ( cell7.String == tkr ):
                cell9 = active_sheet.getCellRangeByName(POS)
                cell9.String = "A"+str(i)
                cell8 = active_sheet.getCellRangeByName("$J"+str(i))
                cell8.NumberFormat = nl
                cell8.Value = close
                addr = UPTD + str(i)
                cell = active_sheet.getCellRangeByName(addr)
                # cell.String = '{:%Y%m%d %H:%M:%S}'.format(datetime.now())
                cell.String = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
                tkr_found = True
                break
        if ( not tkr_found ):
            cell2 = active_sheet.getCellRangeByName("$A"+str(len(cursor.Rows)+1))
            cell2.Value = tkr
            cell3 = active_sheet.getCellRangeByName("$J"+str(len(cursor.Rows)+1))
            cell3.NumberFormat = nl
            cell3.Value = close
            cell = active_sheet.getCellRangeByName(UPTD+str(len(cursor.Rows)+1))
            cell.String = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
            guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
            cursor = active_sheet.createCursorByRange(guessRange)
            cursor.gotoEndOfUsedArea(False)
            cursor.gotoStartOfUsedArea(True)
            guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
            n_ticker = len(cursor.Rows) - 1
            cell4 = active_sheet.getCellRangeByName(LROW)
            cell4.Value = len(cursor.Rows)

        # cell.clearContents(4)
        index += 1
        cell6 = active_sheet.getCellRangeByName(FIDX)
        cell6.Value = index
    infile0.close()

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass

olist = [ n_ticker, path0 ]
print(olist)

sys.exit(0)

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

import uno, sys, time, os, csv
from datetime import datetime
from com.sun.star.uno import RuntimeException
from pprint import pprint

yyyymmdd = sys.argv[1]
DIR0="./datafiles/taiex/after.market"
fname0 = yyyymmdd + '.csv' # // sorted by after_market.sh
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

# take 53:20 to complete
# now  00:42 by sorted data

# FLEN = "$BI1"
# LROW = "$BJ1"
# FIDX = "$Bk1" # in calc, case insensitive
# TIKR = "$BL1"
# POS  = "$BM1"
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
# cell4 = active_sheet.getCellRangeByName(LROW)
# cell4.Value = len(cursor.Rows)
print("# sheet row :{:>4}".format(len(cursor.Rows)))

# theday = datetime.today().strftime('%Y%m%d')
infile0 = open(path0, "r")
# ilist = infile0.readlines()
# print( "# ilist: " + str(len(ilist)) ) # // FIXME: no console output
data = list(csv.reader(infile0, delimiter=':'))
# print(data[0])
# print(data[2][2])
# pprint(data)

# cell5 = active_sheet.getCellRangeByName(FLEN)
# cell5.Value = len(ilist)
print("list size {:>4}".format(len(data)))
infile0.close()

# cell = active_sheet.getCellRangeByName("$BI1")
# print( str(cell.getCellAddress().Column) + ", " + str(cell.getCellAddress().Row) )
# print( cell.getCellAddress().Sheet )
# print( cell.getCellAddress() )
# print( cell.Formula )
# cell.Value = len(doc.getSheets()) # OK
columns = active_sheet.getColumns()
# cell.Value = len( columns )
column = columns.getByName("B")
# column.Width = 3500 # # 1.3590″, works, .7875" = 2000
column.OptimalWidth = True
column = columns.getByName("J")
# column.Width = 2100 # 0.8111″ around 2100a
column.OptimalWidth = True


the_range = active_sheet.getCellRangeByName("B:I")
the_range.Columns.IsVisible = False
the_range = active_sheet.getCellRangeByName("K:BG")
the_range.Columns.IsVisible = False

# @see https://stackoverflow.com/a/72261886
# second_doc = desktop.create_spreadsheet() # testing

t0 = time.time()
# @see https://stackoverflow.com/a/18406412
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
try:
    # index = 2
    # cell6 = active_sheet.getCellRangeByName(FIDX)
    # cell6.Value = index
    tkrs     = [ x[0] for x in data ]
    closes   = [ x[1] for x in data ]
    checked  = [ 0 ] * len(tkrs)
    start = 0
    for i in range(2, len(cursor.Rows)+1):
        tkr = active_sheet.getCellRangeByName("$A"+str(i)).String
        found = False
        for j in range(start, len(tkrs)):
            # print("i {:0>4} j {:0>4} ".format(i, j) + "tkr " + tkrs[j])
            if ( checked[j] == 0 and tkrs[j] == tkr ):
                cell = active_sheet.getCellRangeByName("$J"+str(i))
                cell.NumberFormat = nl
                cell.Value = closes[j]
                cell = active_sheet.getCellRangeByName(UPTD+str(i))
                cell.String = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
                found = True
                break
        if ( found ):
            checked[j] = 1
            start = j + 1
            # print("i {:0>4} tkr {:0>4} found {:0>4}".format(i, tkr, j))
        else:
            print("i {:0>4} tkr {:0>4} not found ".format(i, tkr))
            start = 1

    # // FIXME: possible new in data, therefore search
    missed = 0
    for j in range(0, len(tkrs)):
        if ( checked[j] == 0 ):
            missed +=1
            print("missed: " + tkrs[j])
    print("{:>4} missed".format(missed)) # // FIXME:

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass

t1 = time.time()
# print("{:>.0f} nanoseconds".format(t1-t0))
# print("{:,} nanoseconds".format(t1-t0))
# cell0 = active_sheet.getCellRangeByName(TIKR)
# cell0.String = t_start
# column = columns.getByName("BL")
# column.Width = 5000 # works .7875" = 2000
print("t_start: " + t_start)

# @see https://stackoverflow.com/a/27780763
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
# cell0 = active_sheet.getCellRangeByName(POS)
# cell0.String = "{:0>2}:{:0>2}:{:05.3f}".format(int(hours),int(minutes),seconds)
print( "{:0>2}:{:0>2}:{:05.3f}".format(int(hours),int(minutes),seconds) )
column = columns.getByName("BM")
# column.Width = 3000
# @see https://stackoverflow.com/a/50077601
column.OptimalWidth = True

# olist = [ n_ticker, path0 ]
# print(olist)

sys.exit(0)

'''
    for l in ilist:
        # cursor.gotoStartOfUsedArea(True) # testing
        the_line = l.replace('\n','')
        items = the_line.split(":")
         # @see https://www.twse.com.tw/downloads/zh/products/stock_cod.pdf
        tkr   = items[0].strip() if ( 4 <= len(items[0]) ) \
            else "{:>04d}".format(items[0]) # // FIXME:
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
        # index += 1
'''

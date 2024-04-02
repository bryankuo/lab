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

sheet_name = "20231211"

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
# model = desktop.getCurrentComponent() # doc

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

sheet0 = doc.Sheets.getByName(sheet_name) # interchangable

# take 53:20 to complete
# now  00:42 by sorted data

# FLEN = "$BI1"
# LROW = "$BJ1"
# FIDX = "$Bk1" # in calc, case insensitive
# POS  = "$BM1"
UPTD = "$BH"

# assume no more than 3000 listed.
guessRange = sheet0.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor = sheet0.createCursorByRange(guessRange)
cursor.gotoEndOfUsedArea(False)
cursor.gotoStartOfUsedArea(True)
guessRange = sheet0.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
# print(guessRange.getDataArray())
n_ticker = len(cursor.Rows) - 1
last_row = len(cursor.Rows)

# // TODO:
# @see https://stackoverflow.com/q/27103022
'''
print("test... +")
colDescr = uno.createUnoStruct('com.sun.star.table.TableSortField')
colDescr.Field = 0

# oSortFields(0).Field = 1
#oSortFields(0).SortAscending = TRUE

# sort descriptor
sortDescr = guessRange.createSortDescriptor()
# sortDescr(0).Name = "SortFields"
# sortDescr(0).Value = oSortFields()
for x in sortDescr:
  if x.Name == 'SortFields':
    x.Value = (colDescr,)
    break

guessRange.sort(sortDescr)
print("test... -")
sys.exit(0)
'''

# theday = datetime.today().strftime('%Y%m%d')
infile0 = open(path0, "r")
# ilist = infile0.readlines()
# print( "# ilist: " + str(len(ilist)) )
data = list(csv.reader(infile0, delimiter=':'))
# print(data[0])
# print(data[2][2])
# pprint(data)

# cell5 = sheet0.getCellRangeByName(FLEN)
# cell5.Value = len(ilist)
infile0.close()

# cell = sheet0.getCellRangeByName("$BI1")
# print( str(cell.getCellAddress().Column) + ", " + str(cell.getCellAddress().Row) )
# print( cell.getCellAddress().Sheet )
# print( cell.getCellAddress() )
# print( cell.Formula )
# cell.Value = len(doc.getSheets()) # OK
columns = sheet0.getColumns()
# cell.Value = len( columns )
column = columns.getByName("B")
# column.Width = 3500 # # 1.3590″, works, .7875" = 2000
column.OptimalWidth = True
column = columns.getByName("J")
# column.Width = 2100 # 0.8111″ around 2100a
column.OptimalWidth = True


the_range = sheet0.getCellRangeByName("C:I")
the_range.Columns.IsVisible = False
the_range = sheet0.getCellRangeByName("K:Bg")
the_range.Columns.IsVisible = False
the_range = sheet0.getCellRangeByName("bI:$BL")
the_range.Columns.IsVisible = False

# @see https://stackoverflow.com/a/72261886
# second_doc = desktop.create_spreadsheet() # testing

t0 = time.time()
# @see https://stackoverflow.com/a/18406412
t_start = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
try:
    tkrs     = [ x[0] for x in data ]
    closes   = [ x[1] for x in data ]
    checked  = [ 0 ] * len(tkrs)
    start0=2; start1 = 0; missed = 0
    for i in range(start0, len(cursor.Rows)+1):
        tkr = sheet0.getCellRangeByName("$A"+str(i)).String
        found = False
        for j in range(start1, len(tkrs)):
            tkr0 = tkrs[j]; q0 = closes[j]
            print("{} {} {} {} {}".format(i, tkr, j, tkr0, q0))
            if ( checked[j] == 0 and tkrs[j] == tkr ):
                found = True
                break
        if ( found ):
            cell = sheet0.getCellRangeByName("$J"+str(i))
            cell.NumberFormat = nl
            cell.Value = closes[j]
            cell = sheet0.getCellRangeByName(UPTD+str(i))
            cell.String = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
            checked[j] = 1; start0 = i + 1; start1 = j + 1
            # // FIXME: some in list but not found in spreadsheet -> add one row
            # // FIXME: at the end, sort sheet then save

        else:
            print("i {:0>4} tkr {:0>4} not found in {}".format(i, tkr, path0))
            start = j
            # // FIXME: below 1000 shares ( 1 lot )
            missed +=1

    # // FIXME: possible new in data, therefore search
    print("{:>4} missed".format(missed)) # // FIXME:
    print("# tkr in spreadsheet: {:>4}".format(n_ticker))
    print("list size {:>4}".format(len(data)))
    print("difference {:>4}".format(n_ticker-len(data)))
    '''
    for i in range(0, len(tkrs)):
        if ( checked[i] == 0 ):
            tkr = tkrs[i]
            print("add {:>4} to spreadsheet".format(tkr))
            # new row in spreadsheet
            last_row += 1
            cell = sheet0.getCellRangeByName("$A"+str(last_row))
            cell.Value = tkr
            guessRange = sheet0.getCellRangeByPosition(0, 2, 0, 3000)
            # look up the actual used area within the guess area
            cursor = sheet0.createCursorByRange(guessRange)
            cursor.gotoEndOfUsedArea(False)
            cursor.gotoStartOfUsedArea(True)
            guessRange = sheet0.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
            # print(guessRange.getDataArray())
            n_ticker = len(cursor.Rows) - 1
            last_row = len(cursor.Rows)
    '''
    # doc.CurrentController.select(guessRange) # works
    # what is dispatcher call? How to enable auto filters for a sheet
    # @see dispatcher.executeDispatch
    # https://ask.libreoffice.org/t/how-to-define-the-active-cell/11746/5
    # run macro :
    # https://stackoverflow.com/a/35777552
    # 3rd way run macro
    # https://forum.openoffice.org/en/forum/viewtopic.php?f=20&t=8232

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
# cell0 = sheet0.getCellRangeByName(TIKR)
# cell0.String = t_start
# column.Width = 5000 # works .7875" = 2000
print("t_start: " + t_start)

# @see https://stackoverflow.com/a/27780763
hours, rem = divmod(t1-t0, 3600)
minutes, seconds = divmod(rem, 60)
# cell0 = sheet0.getCellRangeByName(POS)
# cell0.String = "{:0>2}:{:0>2}:{:05.3f}".format(int(hours),int(minutes),seconds)
print( "{:0>2}:{:0>2}:{:05.3f}".format(int(hours),int(minutes),seconds) )
column = columns.getByName("BM")
# column.Width = 3000
# @see https://stackoverflow.com/a/50077601
column.OptimalWidth = True
doc.store()
# sheet6 = doc.Sheets.getByName("Sheet7")
# sheet6.IsVisible = False # works

# olist = [ n_ticker, path0 ]
# print(olist)

sys.exit(0)

'''
# cell.clearContents(4)
'''

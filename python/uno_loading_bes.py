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

#yyyymmdd = sys.argv[1]
DIR0="./datafiles"
# fname0 = yyyymmdd + '.csv' # // sorted by after_market.sh
# path0 = os.path.join(DIR0, fname0)

sheet_name = "20220126"
# print(sheet_name)
src_sheet_name = "Sheet7"

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

active_sheet = doc.Sheets.getByName(sheet_name) # interchangable
src_sheet = doc.Sheets.getByName(src_sheet_name)

# assume no more than 3000 listed.
guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
# look up the actual used area within the guess area
cursor0 = active_sheet.createCursorByRange(guessRange)
cursor0.gotoEndOfUsedArea(False)
cursor0.gotoStartOfUsedArea(True)
guessRange0 = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor0.Rows))
# print(guessRange.getDataArray())
n_ticker = len(cursor0.Rows) - 1
last_row = len(cursor0.Rows)
print(str(n_ticker))

guessRange1 = src_sheet.getCellRangeByPosition(0, 0, 0, 3000)
cursor1 = src_sheet.createCursorByRange(guessRange1)
cursor1.gotoEndOfUsedArea(False)
cursor1.gotoStartOfUsedArea(True)
guessRange1 = src_sheet.getCellRangeByPosition(0, 0, 0, len(cursor1.Rows))
# print(guessRange.getDataArray())
n_src = len(cursor1.Rows)
print(str(n_src))

try:
    start=2
    for i in range(1, len(cursor1.Rows)+1):
        tkr = src_sheet.getCellRangeByName("$A"+str(i)).String
        nm = src_sheet.getCellRangeByName("$b"+str(i)).String
        yr  = src_sheet.getCellRangeByName("C"+str(i)).String
        if ( 4 <= len(yr) ):
            for j in range(start, len(cursor0.Rows)+1):
                tkr0 = active_sheet.getCellRangeByName("$A"+str(j)).String
                nm0 = active_sheet.getCellRangeByName("$b"+str(j)).String
                print("{} {} {} {} {}".format(i, tkr, j, tkr0, nm0))
                if ( tkr0 == tkr ):
                    active_sheet.getCellRangeByName("BL"+str(j)).String = yr
                    print("update {} year".format(tkr))
                    if ( len(nm0) <= 0 ):
                        active_sheet.getCellRangeByName("B"+str(j)).String = nm
                        print("update {} name".format(j))
                    start = j
                    break
                if ( int(tkr0) > int(tkr) ):
                    break

except:
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass

sys.exit(0)

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

# cell5 = active_sheet.getCellRangeByName(FLEN)
# cell5.Value = len(ilist)
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
    tkrs     = [ x[0] for x in data ]
    closes   = [ x[1] for x in data ]
    checked  = [ 0 ] * len(tkrs)
    start = 0; missed = 0
    for i in range(2, len(cursor.Rows)+1):
        tkr = active_sheet.getCellRangeByName("$A"+str(i)).String
        found = False
        for j in range(start, len(tkrs)):
            # print("i {:0>4} j {:0>4} ".format(i, j) + "tkr " + tkrs[j])
            if ( checked[j] == 0 and tkrs[j] == tkr ):
                found = True
                break
        if ( found ):
            cell = active_sheet.getCellRangeByName("$J"+str(i))
            cell.NumberFormat = nl
            cell.Value = closes[j]
            cell = active_sheet.getCellRangeByName(UPTD+str(i))
            cell.String = datetime.now().strftime('%Y%m%d %H:%M:%S.%f')[:-3]
            checked[j] = 1; start = j + 1
            # print("i {:0>4} tkr {:0>4} found {:0>4}".format(i, tkr, j))
            # // FIXME: some in list but not found in spreadsheet -> add one row
            # // FIXME: at the end, sort sheet then save

        else:
            print("i {:0>4} tkr {:0>4} not found in {}".format(i, tkr, path0))
            start = 1
            # // FIXME: below 1000 shares ( 1 lot )
            missed +=1

    # // FIXME: possible new in data, therefore search
    print("{:>4} missed".format(missed)) # // FIXME:
    print("# tkr in spreadsheet: {:>4}".format(n_ticker))
    print("list size {:>4}".format(len(data)))
    print("difference {:>4}".format(n_ticker-len(data)))
    for i in range(0, len(tkrs)):
        if ( checked[i] == 0 ):
            tkr = tkrs[i]
            print("add {:>4} to spreadsheet".format(tkr))
            # new row in spreadsheet
            last_row += 1
            cell = active_sheet.getCellRangeByName("$A"+str(last_row))
            cell.Value = tkr
            guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, 3000)
            # look up the actual used area within the guess area
            cursor = active_sheet.createCursorByRange(guessRange)
            cursor.gotoEndOfUsedArea(False)
            cursor.gotoStartOfUsedArea(True)
            guessRange = active_sheet.getCellRangeByPosition(0, 2, 0, len(cursor.Rows))
            # print(guessRange.getDataArray())
            n_ticker = len(cursor.Rows) - 1
            last_row = len(cursor.Rows)
    # doc.CurrentController.select(guessRange) # works
    # what is dispatcher call? How to enable auto filters for a sheet
    # @see dispatcher.executeDispatch
    # https://ask.libreoffice.org/t/how-to-define-the-active-cell/11746/5

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
# doc.store()

# olist = [ n_ticker, path0 ]
# print(olist)

sys.exit(0)

'''
# cell.clearContents(4)
'''

# make sure python3-uno installed
# /Library/Frameworks/Python.framework/Versions/3.9/bin/python3.9 -m pip install --upgrade pip
# python3 -m pip install uno

# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

# import socket  # only needed on win32-OOo3.0.0
import uno
import sys

# /Applications/LibreOffice.app/Contents/Resources/python uno_kicks.py
ticker = sys.argv[1]
quote = sys.argv[2]

raw_list = []
list2 = []
list4 = []
list5 = []

f = open("datafiles/listed_2.txt", "r")
raw_list = f.readlines()
for element in raw_list:
    list2.append(element.strip())

raw_list.clear()
f = open("datafiles/listed_4.txt", "r")
raw_list = f.readlines()
for element in raw_list:
    list4.append(element.strip())

raw_list.clear()
f = open("datafiles/listed_5.txt", "r")
raw_list = f.readlines()
for element in raw_list:
    list5.append(element.strip())

if ticker in list2:
    print("tse_")
elif ticker in list4:
    print("otc_")
elif ticker in list5:
    print("otcbb")
else:
    print("not listed")
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
# print(len(cursor.Rows))
for i in range(1, len(cursor.Rows)):
    addr_x = "A"+str(i+1)
    cellx = active_sheet.getCellRangeByName(addr_x)
    if ( cellx.String == ticker ):
        addr_q = "J"+str(i+1)
        cellq = active_sheet.getCellRangeByName(addr_q)
        cellq.String = quote
        cellq.CellBackColor = 0xFF0000
        break
#   print(row)
# //TODO: multithreading

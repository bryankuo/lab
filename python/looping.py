#!/usr/bin/env python3

# python3 looping.py [list_type] [task]
# return 0: success

import sys, datetime
from activity import print_header, print_body
# from pe import print_header1, print_body1

# print('Timestamp: {:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()))
if len(sys.argv) < 3:
    print("looping.py [list_type] [task]")
    sys.exit(-1)
# // TODO: support type 5
list_type = sys.argv[1]
task = sys.argv[2]

if ( list_type != "2" ) and \
    ( list_type != "4" ) and \
    ( list_type != "5" ):
    print("invalid list type")
    sys.exit(-2)

# //TODO: handle the case that it could be no data for type 5

fname = "datafiles/listed_" + list_type + ".txt"

def do_operation(ticker):
    if task == "activity":
        print_body(ticker)
    elif task == "pe":
        # from pe import print_header, print_body
        # pe.print_body1(ticker)
        print("TBD")
    else:
        print(ticker+", "+task)

if task == "activity":
    print_header()

if task == "pe":
    # pe.print_header1()
    print("TBD")

line_count = 0
i = 0
myfile = open(fname, "r")
ticker = myfile.readline()
while ticker:
    do_operation(ticker.strip())
    line_count += 1
    i += 1
    ticker = myfile.readline()
myfile.close()
# print('Timestamp: {:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()))
sys.exit(0)

#!/usr/bin/env python3

# python3 looping.py [list_type] [task] [input_file] [output_file]
# return 0: success

import sys, datetime

from selenium import webdriver
from activity import print_header, print_body
from pe import print_header as print_header_per, \
    print_body as print_body_per
from range52w import print_header as print_header_range52w, \
    print_body as print_body_range52w
from eps import \
    get_from_source as get_from_source_eps, \
    print_header as print_header_eps, \
    print_body as print_body_eps

# print('Timestamp: {:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()))
if len(sys.argv) < 3:
    print("looping.py [list_type] [task] [input_file] [output_file]")
    print("list_type: 2, 4, 5(TBD) [task]")
    print("task     : activity, per, range52w, eps")
    sys.exit(-1)

list_type = sys.argv[1]
task = sys.argv[2]

if ( list_type != "2" ) and \
    ( list_type != "4" ) and \
    ( list_type != "5" ):
    print("invalid list type")
    sys.exit(-2)

if ( list_type == "5" ):
    # // TODO:
    print("TBD")
    sys.exit(-3)

in_fname = sys.argv[3]
if ( in_fname is None ):
    in_fname = "datafiles/listed_" + list_type + ".txt"

def do_operation(ticker):
    if task == "activity":
        print_body(ticker)
    elif task == "per":
        print_body_per(ticker)
    elif task == "range52w":
        print_body_range52w(ticker)
    elif task == "eps":
        # // TODO: frequency tuning
        time_wait_sec = andom.randrange(10, 120)
        print("wait " + time_wait_sec)
        time.sleep(time_wait_sec)
        soup = get_from_source_eps(ticker)
        name = None
        print_body_eps(ticker, name, soup)
    else:
        print(ticker+", "+task)

def print_task_header(ofile):
    if task == "activity":
        print_header()
    elif task == "per":
        print_header_per()
        # // TODO: polymorphizm via subclassing
    elif task == "range52w":
        print_header_range52w()
    elif task == "eps":
        mockup_ticker = "1101"
        soup = get_from_source_eps(mockup_ticker)
        print_header_eps(mockup_ticker, soup, ofile)
    else:
        print("ph TBD 2")

out_fname = sys.argv[4]
if ( out_fname is None ):
    print("output filename not specified.")
else:
    ofile = open(out_fname, "a")

print_task_header(ofile)
line_count = 0
i = 0
myfile = open(in_fname, "r")
ticker = myfile.readline()
while ticker:
    do_operation(ticker.strip())
    line_count += 1
    i += 1
    ticker = myfile.readline()
myfile.close()
ofile.close()
# print('Timestamp: {:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()))
sys.exit(0)

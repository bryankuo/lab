#!/usr/bin/env python3

# python3 looping.py [input_file] [task] [output_file]
# return 0: success

import sys, datetime, random, time
from selenium import webdriver

from activity import print_header, print_body

from pe import print_header as print_header_per, \
    print_body as print_body_per

from range52w import \
    print_header as print_header_range52w, \
    print_body   as print_body_range52w

from eps import \
    get_from_source as get_from_source_eps, \
    print_header as print_header_eps, \
    print_body as print_body_eps

# print('Timestamp: {:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()))
if len(sys.argv) < 3:
    print("looping.py [input_file] [task] [output_file]")
    print("task     : activity, per, range52w, eps")
    sys.exit(-1)

in_fname = sys.argv[1]
if ( in_fname is None ):
    print("invalid input file")
    sys.exit(-4)

task = sys.argv[2]
task_available = ["activity", "per", "range52w", "eps"]
if ( task not in task_available ):
    print("invalid task")
    sys.exit(-2)

def do_operation(ln, ticker, ofile):
    print(f'{ln:04}' + " ticker " + ticker + " " + task)
    if task == "activity":
        print_body(ticker, ofile)
    elif task == "per":
        print_body_per(ticker, ofile)
    elif task == "range52w":
        print_body_range52w(ticker, ofile)
    elif task == "eps":
        # frequency tuning
        # low profile, don't do this at night,
        # cover by market trading hours
        time_wait_sec = random.randint(-30, 20) + 60 * 1
        print("wait " + str(time_wait_sec) + " seconds,")
        time.sleep(time_wait_sec)
        soup = get_from_source_eps(ticker)
        name = None
        print_body_eps(ticker, name, soup, ofile)
        print('Timestamp: {:%Y-%m-%d %H:%M:%S}' \
            .format(datetime.datetime.now()))
    else:
        print(ticker+", "+task)

def print_task_header(ofile):
    mockup_ticker = "2330" # //TODO: random seed generator
    if task == "activity":
        print_header(mockup_ticker, ofile)
    elif task == "per":
        print_header_per(mockup_ticker, ofile)
    elif task == "range52w":
        print_header_range52w(mockup_ticker, ofile)
    elif task == "eps":
        soup = get_from_source_eps(mockup_ticker)
        print_header_eps(mockup_ticker, soup, ofile)
    else:
        print("ph TBD 2")

out_fname = sys.argv[3]
if ( out_fname is None ):
    print("output filename not specified.")
else:
    ofile = open(out_fname, "w")

try:
    print('Timestamp: {:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()))
    start_time = time.time()

    print_task_header(ofile)
    line_count = 0
    i = 0
    myfile = open(in_fname, "r")
    ticker = myfile.readline()
    while ticker:
        do_operation(line_count, ticker.strip(), ofile)
        line_count += 1
        i += 1
        ticker = myfile.readline()
finally:
    myfile.close()
    ofile.close()
    print('Timestamp: {:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()))
    elapsed_time = time.time() - start_time
    print('It takes '+"{}".format(elapsed_time)+' seconds')

sys.exit(0)

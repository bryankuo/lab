#!/usr/bin/env python3

import sys, activity

fname = "datafiles/listed_2.txt"
line_count = 0
i = 0
myfile = open(fname, "r")
myline = myfile.readline()
while myline:
    myline = myfile.readline()
    activity.some_func(myline.strip())
    line_count += 1
    i += 1
myfile.close()
sys.exit(0)

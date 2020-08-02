#!/usr/bin/env python3

import sys,csv

'''
def open_and_parse(fname):
    f = open(fname, "r")
    print(f.readline())
    return 0
'''

def open_and_parse(fname):
    with open(fname, 'r') as csvfile:
        csv_reader = csv.reader(csvfile, delimiter=',')
        line_count = 0
        for row in csv_reader:
            line_count += 1
            print(row)
        print("#row: " + line_count)
    return 0

def main():
    open_and_parse(sys.argv[1])

if __name__ == "__main__":
	main()

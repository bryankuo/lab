#!/usr/bin/env python3

import sys,csv

def open_and_parse(lines, fname):
    with open(fname, 'r') as csvfile:
        csv_reader = csv.reader(csvfile, delimiter=':')
        line_count = 0
        for row in csv_reader:
            line_count += 1
            lines.append(row)
        # print("#row: " + str(line_count) + " " + fname)
    return 0

market_values   = []
t50_components  = []
msci_components = []

def main():
    open_and_parse(market_values, sys.argv[1])
    open_and_parse(t50_components, sys.argv[2])
    open_and_parse(msci_components, sys.argv[3])
    '''
    print(*market_values)
    print("\n")
    print(*t50_components)
    print("\n")
    print(*msci_components)
    '''
    '''
    for x in market_values:
        tkr_name = x[1]

        t50_rank = " "
        for y in t50_components:
            if tkr_name == y[0]:
                t50_rank = y[
        x.append(t50_rank)

        for z in msci_components:
            z[1]
    '''
if __name__ == "__main__":
	main()

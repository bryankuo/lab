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

title = \
    ['代號', '資本', '台股權值', '市值排名', '台灣50排名', \
    'MSCI排名', '中100排名']
market_values = []
t50_components  = []
msci_components = []
m100_components = []

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

    for x in market_values:
        tkr_name = x[1]

        t50_rank = 0
        index = 0
        for y in t50_components:
            # print( tkr_name, y[0] )
            if tkr_name == y[0].strip():
                t50_rank = index
                break
            index += 1
        x.append(t50_rank)

        index = 1
        msci_rank = 0
        for z in msci_components:
            if tkr_name == z[1]:
                msci_rank = index
                break
            index += 1
        x.append(msci_rank)

    print(title[0], end=":")
    print(title[1], end=":")
    print(title[2], end=":")
    print(title[3], end=":")
    print(title[4], end=":")
    print(title[5], end=":")
    print(title[6], end="\n")

    for i in range(len(market_values)):
        print(market_values[i][1], end=':')
        print(market_values[i][2], end=':')
        print(market_values[i][3], end=':')
        print(market_values[i][0], end=':')
        print(market_values[i][4], end=':')
        print(market_values[i][5], end='\n')
if __name__ == "__main__":
	main()

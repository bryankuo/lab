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
    ['代號', '市值(E)', '台股權值', '市值排名', '台灣50排名', \
    'MSCI排名', '中100排名']
top100_market_values = []

t50_components  = []
# alternative source
# https://histock.tw/global/globalclass.aspx?mid=0&id=2
# https://histock.tw/global/globalclass.aspx?mid=0&id=0
# https://www.wantgoo.com/index/%5E539/stocks
# https://histock.tw/twclass/A901
msci_components = []

m100_components = []
# which one is the most updated?
# https://histock.tw/global/globalclass.aspx?mid=0&id=3
# most updated ( with printed date )
# https://www.wantgoo.com/index/%5E543/stocks
# https://histock.tw/twclass/A905

# A902 https://histock.tw/twclass/A902

top150_market_values = []

merged_tab = []

def main():
    open_and_parse(top100_market_values, sys.argv[1])
    open_and_parse(t50_components, sys.argv[2])
    open_and_parse(msci_components, sys.argv[3])
    open_and_parse(top150_market_values, sys.argv[4])
    # // TODO:
    # open_and_parse(m100_components, sys.argv[5])

    '''
    print(*market_values)
    print("\n")
    print(*t50_components)
    print("\n")
    print(*msci_components)
    '''

    for i in range(1, len(top150_market_values)):
        top150 = top150_market_values[i]
        rank = top150[0]
        tkr_name = top150[1]
        mkt_val = top150[2]
        if ( i < len(top100_market_values) ):
            weight = top100_market_values[3]
        else:
            weight = 0

        index = 1
        msci_rank = 0
        for z in msci_components:
            if tkr_name == z[1]:
                msci_rank = index
                break
            index += 1
        x.append(msci_rank)

        t50_rank = 0
        index = 0
        for y in t50_components:
            # print( tkr_name, y[0] )
            if tkr_name == y[0].strip():
                t50_rank = index
                break
            index += 1

        m100_rank = 0

        merged_tab.append(tkr_name)
        merged_tab.append(mkt_val)
        merged_tab.append(weight)
        merged_tab.append(rank)
        merged_tab.append(t50_rank)


    '''
    for x in top100_market_values:
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
    '''

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

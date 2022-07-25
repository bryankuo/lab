#!/usr/bin/env python3

import sys,csv
from pprint import pprint

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
    ['市值排名', '代號', '台股權值', 'MSCI排名', '台灣50排名', \
     '中100排名', '市值(E)']

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
    open_and_parse(m100_components, sys.argv[5])

    # print(*top150_market_values)
    merged_tab.append(title)

    for i in range(1, len(top150_market_values)):
        top150 = top150_market_values[i]
        rank = top150[0]
        tkr_name = top150[1]
        mkt_val = top150[2]

        weight = 0
        for i in range(1, len(top100_market_values)):
            if tkr_name == top100_market_values[i][1] :
                weight = top100_market_values[i][3]
                break

        # mark msci rank
        msci_rank = 0
        for i in range(1, len(msci_components)):
            if tkr_name == msci_components[i][1]:
                msci_rank = i
                break

        # mark t50 rank
        t50_rank = 0
        for i in range(0, len(t50_components)):
            if tkr_name == t50_components[i][0].strip():
                t50_rank = i + 1
                break

        # mark m100 rank
        m100_rank = 0
        for i in range(1, len(m100_components)):
            if tkr_name == m100_components[i][0].strip():
                m100_rank = i
                break

        r=[]
        r.append("{:>04s}".format(rank))
        r.append(tkr_name)
        r.append(weight)
        r.append(msci_rank)
        r.append(t50_rank)
        r.append(m100_rank)
        r.append("{:>.02f}".format(mkt_val))
        merged_tab.append(r)

    for i in range(0, len(merged_tab)):
        print(merged_tab[i][0], end=':')
        print(merged_tab[i][1], end=':')
        print(merged_tab[i][2], end=':')
        print(merged_tab[i][3], end=':')
        print(merged_tab[i][4], end=':')
        print(merged_tab[i][5], end=':')
        print(merged_tab[i][6], end='\n')

if __name__ == "__main__":
	main()

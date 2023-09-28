#!/usr/bin/python3

# python3 transotc.py [tkr] [stamp] [infile]
# output: sort by seq,broker,price,buy,sell
# return 0: success

import sys, re, unicodedata

ticker   = sys.argv[1]
stamp    = sys.argv[2]
filename = sys.argv[3]

n_line = 0; n_trans = 0; new_table = []
t0 = []; t1 = []
with open(filename, 'r') as infile:
    for i in range( 1, 4):
        infile.readline()
        i = i + 1
    contents = infile.readline()
    while contents:
        parts = contents.split(',,')
        if ( len(parts) < 2 ):
            for r in re.findall(r'".+?"|[\w-]+', parts[0].strip(' ')):
                t0.append(r.strip('"'))
            new_table.append(t0.copy())
            n_trans = n_trans + 1
        else:
            for r in re.findall(r'".+?"|[\w-]+', parts[0].strip(' ')):
                t0.append(r.strip('"'))
            new_table.append(t0.copy())
            n_trans = n_trans + 1

            for r in re.findall(r'".+?"|[\w-]+', parts[1].strip(' ')):
                t1.append(r.strip('"'))
            new_table.append(t1.copy())
            n_trans = n_trans + 1
        t0.clear(); t1.clear()
        n_line = n_line + 1
        contents = infile.readline()
    infile.close()

file_name = 'datafiles/' + ticker + '/' + stamp + '.txt'
with open(file_name, 'w') as outfile:
    fmt  = '{0:4s}:{1:<10s}:{2:7s}:{3:<7s}:{4:<7s}\n'
    fmt1 = '{:04d}:{:<s}:{:.2f}:{:d}:{:d}\n'
    outfile.write(fmt.format('seq', 'broker', 'price', '#buy', '#sell'))
    for trans in new_table:
        seq    = int( trans[0].strip() ) #
        bno    = trans[1][0:4].strip(' ')
        bdes   = trans[1][4:].strip(' ')
        # print(bdes.encode("utf-8").hex())
        broker = bno + "-" + bdes # bdes is utf-8 variable length
        # broker = unicodedata.east_asian_width(ubroker)
        # @see https://stackoverflow.com/a/4632373
        price  = float(trans[2].strip().replace(',',''))
        # float(trans[2].text.strip())
        bid    = int(int(trans[3].strip().replace(',',''))/1000)
        ask    = int(int(trans[4].strip().replace(',',''))/1000)
        outfile.write(fmt1.format(seq, broker, price, bid, ask))
        # .ljust(10)
outfile.close()

print( ticker + " " + stamp + " " + \
    str(n_line) + " line processed, " + \
    str(n_trans) + " transactions." )

sys.exit(0)

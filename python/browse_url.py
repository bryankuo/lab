#!/usr/bin/python3

# minimum python function for shell script

# python3 browse_url.py [url]
# return 0: success

import sys, webbrowser

webbrowser.open(sys.argv[1])

sys.exit(0)

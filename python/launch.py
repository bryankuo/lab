#!/usr/bin/python3

# python3 launch.py
# return 0 success otherwise fail

import os, sys, subprocess

# subprocess.call(['soffice', '--headless', '--convert-to', 'txt:Text', 'document_to_convert.doc'])

# print(os.getcwd())
# subprocess.Popen([os.getcwd()+"LibreOffice.app", ""])

# /Applications/LibreOffice.app/Contents/MacOS/soffice --writer
# @see
# https://ask.libreoffice.org/en/question/3317/is-it-possible-to-open-writer-directly-on-mac-os-x/?answer=259775#post-id-259775
# /Applications/LibreOffice.app/Contents/MacOS/soffice --calc
# /Applications/LibreOffice.app/Contents/MacOS/soffice --calc 9904.txt
# utf-8
subprocess.Popen(["/Applications/LibreOffice.app/Contents/MacOS/soffice", "9904.txt"])

sys.exit(0)

#!/usr/bin/python3

# python3 web_search.py

# return 0: success

import sys, requests, time, webbrowser
from urllib.parse   import quote
from urllib.request import urlopen

addr = sys.argv[1]
url = "https://www.google.com/maps/search/%22" \
    + quote(addr) \
    + "%22/@24.3225713,121.6600514,17z/data=!3m1!4b1"

# street view with photo
"https://www.google.com/maps/place/1f,+No.+669,+Shuiyuan+Rd,+Fengyuan+District,+Taichung+City,+420/@24.2547349,120.7273829,3a,75y,29.12h,90t/data=!3m8!1e2!3m6!1sAF1QipMKUWiMxxf4Y1acl9do4kQUsWWh2vPY0vmCnVYU!2e10!3e12!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipMKUWiMxxf4Y1acl9do4kQUsWWh2vPY0vmCnVYU%3Dw172-h86-k-no!7i4032!8i2016!4m5!3m4!1s0x34691a13d95eca87:0xd72760a2e72ddd9b!8m2!3d24.254735!4d120.727383"

print(url)
webbrowser.open(url)
print('\a') # beep
sys.exit(0)

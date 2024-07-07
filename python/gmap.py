#!/usr/bin/python3

# python3 web_search.py

# return 0: success

import sys, requests, time, webbrowser
from urllib.parse   import quote
from urllib.request import urlopen

# addr = sys.argv[1]
# presume address as mandrin input or google address

'''
url = "https://www.google.com/maps/search/%22" \
    + quote(addr) \
    + "%22/@24.3225713,121.6600514,17z/data=!3m1!4b1"
'''
# open google map
# url = 'https://www.google.com.tw/maps/@24.9508903,121.2053851,15z'
# url = 'https://www.google.com.tw/maps/'
# url = 'https://www.google.com/maps/?hl=zh-tw'
# url = 'https://www.google.com/maps/@25.9508903,121.2053851,9z?hl=zh-tw'
# url = 'https://www.google.com/maps/@25.9508903,119.2053851,9z?hl=zh-tw'
# google map url parameters
# https://developers.google.com/maps/documentation/urls/get-started
# url = 'https://www.google.com/maps/search/?api=1&query=centurylink+field
#addr = '苗栗縣頭份鎮中正路67號2樓'
addr='台中市清水區中山路196號5樓'
# url = 'https://www.google.com/maps/search/?api=1&query='+quote(addr)
opt='&map_action=map&zoom=0'
#url = 'https://www.google.com/maps/search/?api=1'+opt+'&query='+quote(addr)
#url='https://www.google.com/maps/@?api=1&map_action=map&center=-33.712206%2C150.311941&zoom=12&basemap=terrainan'
#url='https://www.google.com/maps/@?api=1&map_action=map&center=24.6871851%2C120.9111578&zoom=21&basemap=satellite'
# url='https://www.google.com/maps/@?api=1&map_action=map&zoom=17&basemap=terrain'+'&query='+quote(addr)
url='https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=48.857832%2C2.295226&heading=-45&pitch=38&fov=80'
# how to add a marker to newly opened google map?

# @see https://stackoverflow.com/a/43211266/969049
#
# gmap package?
# Geocoder python package?
# gmplot library?
# as long as running in jsfiddle, my requirement is fullfilled.
# @see
# https://developers.google.com/maps/documentation/javascript/examples/circle-simple
# then a geodecoder is required
# circle simple on jsfiddle works
# https://developers.google.com/maps/documentation/javascript/examples/circle-simple

# https://www.google.com/maps/place/351,+Miaoli+County,+Toufen+City,+中正路67號2/@24.687423,120.9104858,3a,75y,282.62h,90t/data=!3m10!1e1!3m8!1sc1SlhFDb9gbGJ8K1GOZUVg!2e0!6shttps:%2F%2Fstreetviewpixels-pa.googleapis.com%2Fv1%2Fthumbnail%3Fpanoid%3Dc1SlhFDb9gbGJ8K1GOZUVg%26cb_client%3Dmaps_sv.tactile.gps%26w%3D203%26h%3D100%26yaw%3D211.51964%26pitch%3D0%26thumbfov%3D100!7i16384!8i8192!9m2!1b1!2i51!4m5!3m4!1s0x34684cc76e8c5d79:0xe5d91894a421d5a4!8m2!3d24.6871754!4d120.9111685

# street view with photo
# url="https://www.google.com/maps/place/1f,+No.+669,+Shuiyuan+Rd,+Fengyuan+District,+Taichung+City,+420/@24.2547349,120.7273829,3a,75y,29.12h,90t/data=!3m8!1e2!3m6!1sAF1QipMKUWiMxxf4Y1acl9do4kQUsWWh2vPY0vmCnVYU!2e10!3e12!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipMKUWiMxxf4Y1acl9do4kQUsWWh2vPY0vmCnVYU%3Dw172-h86-k-no!7i4032!8i2016!4m5!3m4!1s0x34691a13d95eca87:0xd72760a2e72ddd9b!8m2!3d24.254735!4d120.727383"
# visual verification broker name

# google earth pro
# url="https://earth.google.com/web/@8.52297896,112.64555318,-5903.30443334a,8126338.3137238d,35y,0h,0t,0r"

# url="https://earth.google.com/web/@-5.11627609,87.33777897,-4185.56308614a,8124620.3618753d,35y,-0h,0t,0r"

# open street map
# url="https://www.openstreetmap.org/#map=7/23.611/120.768"
# zoom-in
# url="https://www.openstreetmap.org/#map=9/23.6110/120.7680"
# open street map API
# https://wiki.openstreetmap.org/wiki/API
# currently working on:
# https://cutt.ly/yGardUq
# url="https://www.openstreetmap.org/#map=10/25.9508903/121.2053851"

print(url)
webbrowser.open(url)
print('\a') # beep
sys.exit(0)


# pygmap package to draw plot
# pip install pygmaps
# python3 -m pip install pygmaps
# mac seems not working
# open street map?
# google earth
# https://earth.google.com/web/@44.54109221,-65.63571745,8615.44979582a,22243136.74901247d,35y,0h,0t,0r
# trying open 2 maps in webbrowser, input coordinates
# ref gmap.py


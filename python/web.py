#!/usr/bin/python3
import requests

# t.ly/1QGN
# response = requests.get('https://pchome.megatime.com.tw/market/sto0')
# OK
# response = requests.get('http://www.python.org')
# OK
response = requests.get('https://invest.cnyes.com/indices/major')

print (response.status_code)
print (response.content)

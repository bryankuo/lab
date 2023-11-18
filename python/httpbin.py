#!/usr/bin/env python3

import requests, sys, os, random
sys.path.append(os.getcwd())
import useragents as ua

# print(ua.list[2])
# r.test(1)

# headers = {}
# headers = {'User-Agent': ua.list[2]}
user_agent = random.choice(ua.list)
headers = {'User-Agent': user_agent}

response = requests.get('http://httpbin.org/headers', headers=headers)

print(response.status_code)
print(response.text)

# find . -type f -iname '*.py' -print | xargs ls -lt
# find . -type f -iname '*.py' | xargs grep -rnp --color="auto" -e "response = requests.get" | wc -l
# find . -type f -iname '*.py' | xargs grep -rnp --color="auto" -e "requests.get" | wc -l
# find . -type f -iname '*.py' | xargs grep -rnp --color="auto" -e "response=" | wc -l
# find . -type f -iname '*.py' -print | xargs ls -lt
# find . -type f -iname '*.py' -print | xargs ls -t | xargs grep -rnp --color="auto" -e "response = requests.get" | wc -l
# find . -type f -iname '*.py' -print | xargs ls -t | xargs grep -rnp --color="auto" -e "requests.get" | wc -l
# find . -type f -iname '*.py' -print | xargs ls -t | xargs grep -rnp --color="auto" -e "response=" | wc -l

#!/usr/bin/python3

# python3 104_search.py 2330
# return 0: success

import sys, webbrowser

ticker = sys.argv[1]
url = "https://www.google.com/search?q="+ticker+"+104&client=safari&rls=en&sxsrf=AOaemvJQ_3UVNBgOgvmw8LgOPjMQ6ukDmw%3A1637394407406&ei=56eYYZ__F-DR2roPua-g6A4&ved=0ahUKEwjfjorAuab0AhXgqFYBHbkXCO0Q4dUDCA0&uact=5&oq=6152+104&gs_lcp=Cgdnd3Mtd2l6EAM6CAgAEAcQChAeOgQIABAeOgYIABAIEB46CAgAEAgQBxAeOgIIJjoGCAAQBxAeOgUIABCRAjoFCAAQgAQ6CwguEIAEEMcBEK8BOggIABAHEAUQHkoECEEYAVD-BFiPKGC1KmgCcAB4AIABcYgBkwWSAQM3LjKYAQCgAQHAAQE&sclient=gws-wiz"
webbrowser.open(url)
sys.exit(0)

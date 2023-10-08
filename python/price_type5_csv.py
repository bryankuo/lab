import csv
import requests

# @see https://stackoverflow.com/a/35371451
CSV_URL = 'http://samplecsvs.s3.amazonaws.com/Sacramentorealestatetransactions.csv'
markt_url = 'https://www.tpex.org.tw/web/emergingstock/historical/daily/EMDaily_dl.php?l=zh-tw&f=EMdes010.20231006-C.csv'
block_url = 'https://www.tpex.org.tw/web/emergingstock/historical/daily/EMDaily_dl.php?l=zh-tw&f=EMdcs002.20231006-C.csv'


with requests.Session() as s:
    download = s.get(markt_url)

    decoded_content = download.content.decode('utf-8')
    # decoded_content = download.content.decode('ISO8859')
    # decoded_content = download.content.decode('BIG5')

    cr = csv.reader(decoded_content.splitlines(), delimiter=',')
    my_list = list(cr)
    for row in my_list:
        print(row)

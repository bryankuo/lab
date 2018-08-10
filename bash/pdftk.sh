# sudo apt-get install pdftk ( ubuntu 16.04 )
# pdftk commandline merge 2 pdf doc,
pdftk etag-m.pdf etag-d.pdf output merged.pdf
pdftk 2018_annual_meeting_credential_request.pdf cat 3-3 output req.pdf
# 18.04 via docker 16.04
sudo /usr/bin/pdftk etag0709m.pdf etag0709d.pdf output 0709.pdf
# leaving permission as a //TODO: item
# sudo snap install pdftk ( https://goo.gl/RosBhu )

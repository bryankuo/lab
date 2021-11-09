#!/bin/bash
/Applications/LibreOffice.app/Contents/MacOS/soffice --calc \
"datafiles/activity_watchlist.ods" \
--accept="socket,host=localhost,port=2002;urp;StarOffice.ServiceManager"
exit 0

#!/bin/bash
/Applications/LibreOffice.app/Contents/MacOS/soffice --calc \
"$1" \
--accept="socket,host=localhost,port=2002;urp;StarOffice.ServiceManager"
exit 0

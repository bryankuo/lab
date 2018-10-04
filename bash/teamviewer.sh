#!/bin/bash
# restart teamviewer: ( https://goo.gl/82tSX2 )
sudo teamviewer --daemon stop
sudo teamviewer --daemon start
sudo teamviewer --daemon restart

# How to find my TeamViewer ID on SSH? ( https://goo.gl/SxAeo8 )
sudo teamviewer --passwd newPassword # testcli1234
teamviewer -info
exit 0

#!/bin/bash
echo "scrap msci components and launch libreoffice..."
python3 msci_components.py > datafiles/msci.txt
python3 launch.py datafiles/msci.txt
exit 0

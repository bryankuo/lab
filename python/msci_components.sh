#!/bin/bash
echo "scrap msci components and launch libreoffice..."
python3 msci_components.py > datafiles/msci.txt
# python3 launch.py datafiles/msci.txt
python3 t50_component.py > datafiles/t50.txt
python3 get_mrkt_value.py > datafiles/top100_market_value.txt
exit 0

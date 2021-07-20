#!/bin/bash
echo "scrap msci components..."
python3 msci_components.py > datafiles/msci.txt
echo "scrap t50 components..."
python3 t50_component.py > datafiles/t50.txt
echo "scrap market value..."
python3 get_mrkt_value.py > datafiles/top100_market_value.txt
echo "merge..."
python3 merge.py \
    datafiles/top100_market_value.txt \
    datafiles/t50.txt datafiles/msci.txt \
    > datafiles/merge.txt
echo "open..."
python3 launch.py datafiles/merge.txt
exit 0

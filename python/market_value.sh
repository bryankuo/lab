#!/bin/bash
echo "scrap top 100 market value..."
FNAME=top100_market_value.txt
python3 get_market_capital.py > datafiles/$FNAME
python3 launch.py datafiles/$FNAME
exit 0

#!/bin/bash
echo -e ' \n '
for i in {1..8};
do

echo -e ' \t '"TableViewColumn {"
echo -e ' \t '"id: bcuSmokeDetectStatus"$i"Column"
echo -e ' \t '"title: \"BCU Smoke Detect Status $i\""
echo -e ' \t '"role: \"bcuSmokeDetectStatus$i\""
echo -e ' \t '"horizontalAlignment: Text.AlignHCenter"
echo -e ' \t '"movable: false"
echo -e ' \t '"resizable: false"
echo -e ' \t '"width: 250"
echo -e ' \t '"}"
echo " "

done

exit 0;

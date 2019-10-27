#!/bin/bash
echo -e ' \n '
for i in {1..8};
do

echo -e ' \t '"TableViewColumn {"
echo -e ' \t '"id: vcuIoStatus"$i"Column"
echo -e ' \t '"title: \"VCU IO Status $i\""
echo -e ' \t '"role: \"vcuIOStatus$i\""
echo -e ' \t '"horizontalAlignment: Text.AlignHCenter"
echo -e ' \t '"movable: false"
echo -e ' \t '"resizable: false"
echo -e ' \t '"width: 150"
echo -e ' \t '"}"
echo " "

done

exit 0;

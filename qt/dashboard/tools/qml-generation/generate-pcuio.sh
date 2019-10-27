#!/bin/bash
echo -e ' \n '
for i in {1..8};
do

echo -e ' \t '"TableViewColumn {"
echo -e ' \t '"id: pcuIoStatus"$i"Column"
echo -e ' \t '"title: \"PCU IO Status $i\""
echo -e ' \t '"role: \"pcuIOStatus$i\""
echo -e ' \t '"horizontalAlignment: Text.AlignHCenter"
echo -e ' \t '"movable: false"
echo -e ' \t '"resizable: false"
echo -e ' \t '"width: 200"
echo -e ' \t '"}"
echo " "

done

exit 0;

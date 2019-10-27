#!/bin/bash
echo -e ' \n '
for i in {1..48};
do

echo -e ' \t '"TableViewColumn {"
echo -e ' \t '"id: t"$i"Column"
echo -e ' \t '"title: \"T$i\""
echo -e ' \t '"role: \"t$i\""
echo -e ' \t '"horizontalAlignment: Text.AlignHCenter"
echo -e ' \t '"movable: false"
echo -e ' \t '"resizable: false"
echo -e ' \t '"width: 100"
echo -e ' \t '"}"
echo " "

done

exit 0;

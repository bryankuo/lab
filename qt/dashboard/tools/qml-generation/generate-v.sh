#!/bin/bash
for i in {1..168};
do

echo -e ' \n '
echo -e ' \t '"TableViewColumn {"
echo -e ' \t '"id: v"$i"Column"
echo -e ' \t '"title: \"V$i\""
echo -e ' \t '"role: \"v$i\""
echo -e ' \t '"horizontalAlignment: Text.AlignHCenter"
echo -e ' \t '"movable: false"
echo -e ' \t '"resizable: false"
echo -e ' \t '"width: 100"
echo -e ' \t '"}"

done

exit 0;

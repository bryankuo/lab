#!/bin/bash
for i in $(seq -f "%03g" 1 100)
do
    #echo $i
    #echo "http://radio-download.dw.de/Events/dwelle/deutschkurse/audiotrainer/eng/Audiotrainer_Englisch_Lektion$i.mp3"
    wget "http://radio-download.dw.de/Events/dwelle/deutschkurse/audiotrainer/eng/Audiotrainer_Englisch_Lektion$i.mp3"
done

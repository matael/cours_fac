#!/bin/sh

./annot.sh annexe_1_raw.png "Annexe 1" 30
./annot.sh annexe_2_raw.png "Annexe 2" 30
./annot.sh annexe_3_raw.png "Annexe 3" 30
mv modif_annexe_1_raw.png annexe_1.png
mv modif_annexe_2_raw.png annexe_2.png
mv modif_annexe_3_raw.png annexe_3.png

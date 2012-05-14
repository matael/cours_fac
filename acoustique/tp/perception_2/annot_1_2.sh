#!/bin/sh

./annot.sh battement_multiples.png "Annexe 1" 30
./annot.sh modif_battement_multiples.png "Annexe 2" 425
mv modif_modif_battement_multiples.png annexe_1_2.png
rm modif_battement_multiples.png

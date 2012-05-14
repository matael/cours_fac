#!/bin/sh

convert -gravity NorthWest -pointsize 25 -stroke black -fill black -draw "text 50,$3 '$2'" $1 png:modif_$1

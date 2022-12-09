#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

rm -f Template/o/*.o
rm -f Template/o/*.lst
rm -f Template/o/*.asm
rm -f Template/o/*.sym


$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateCursorTiles.o Template/res/tiles/templateCursorTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFaceTiles.o Template/res/tiles/templateFaceTiles.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFace1Map.o Template/res/maps/templateFace1Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFace2Map.o Template/res/maps/templateFace2Map.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateSloopygoopMinuteWaltz.o Template/res/audio/templateSloopygoopMinuteWaltz.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFaceMicrogame.o Template/states/templateFaceMicrogame.c

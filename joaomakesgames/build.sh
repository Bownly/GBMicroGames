#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

rm -f joaomakesgames/o/*.o
rm -f joaomakesgames/o/*.lst
rm -f joaomakesgames/o/*.asm
rm -f joaomakesgames/o/*.sym

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o joaomakesgames/o/sound.o joaomakesgames/sound.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o joaomakesgames/o/BalloonsPopping.o joaomakesgames/resources/sprites/BalloonsPopping.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o joaomakesgames/o/ThumbsUp.o joaomakesgames/resources/sprites/ThumbsUp.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o joaomakesgames/o/Ui.o joaomakesgames/resources/sprites/Ui.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o joaomakesgames/o/Aim.o joaomakesgames/resources/sprites/Aim.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o joaomakesgames/o/Balloons.o joaomakesgames/resources/sprites/Balloons.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o joaomakesgames/o/BackgroundTiles.o joaomakesgames/resources/background/BackgroundTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o joaomakesgames/o/Background.o joaomakesgames/resources/background/Background.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o joaomakesgames/o/saveTheKidsMicrogame.o joaomakesgames/states/saveTheKidsMicrogame.c

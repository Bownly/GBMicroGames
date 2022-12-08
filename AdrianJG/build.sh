#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

rm -f AdrianJG/o/*.o
rm -f AdrianJG/o/*.lst
rm -f AdrianJG/o/*.asm
rm -f AdrianJG/o/*.sym

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo6 -c -o AdrianJG/o/adrianJGClockwiseCharacterTiles.o AdrianJG/res/tiles/adrianJGClockwiseCharacterTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo6 -c -o AdrianJG/o/adrianJGClockwiseUIYouTiles.o AdrianJG/res/tiles/adrianJGClockwiseUIYouTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo6 -c -o AdrianJG/o/adrianJGClockwiseArmsTiles.o AdrianJG/res/tiles/adrianJGClockwiseArmsTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo6 -c -o AdrianJG/o/adrianJGHitTheNoteTiles.o AdrianJG/res/tiles/adrianJGHitTheNoteTiles.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo6 -c -o AdrianJG/o/adrianJGHitTheNoteBackground.o AdrianJG/res/backgrounds/adrianJGHitTheNoteBackground.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo6 -c -o AdrianJG/o/adrianJGClockwiseSong.o AdrianJG/res/audio/adrianJGClockwiseSong.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo6 -c -o AdrianJG/o/adrianJGClockwiseMicrogame.o AdrianJG/states/adrianJGClockwiseMicrogame.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo6 -c -o AdrianJG/o/adrianJGHitTheNoteMicrogame.o AdrianJG/states/adrianJGHitTheNoteMicrogame.c
#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

rm -f SynchingFeeling/o/*.o
rm -f SynchingFeeling/o/*.lst
rm -f SynchingFeeling/o/*.asm
rm -f SynchingFeeling/o/*.sym

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o SynchingFeeling/o/sfx.o SynchingFeeling/sfx.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o SynchingFeeling/o/synchingFeelingHumptyDumptySong.o SynchingFeeling/res/audio/synchingFeelingHumptyDumptySong.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o SynchingFeeling/o/sloopyGoopSingingMushroomSong.o SynchingFeeling/res/audio/sloopyGoopSingingMushroomSong.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o SynchingFeeling/o/synchingFeelingEggTiles.o SynchingFeeling/res/tiles/synchingFeelingEggTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o SynchingFeeling/o/synchingFeelingEggMaps.o SynchingFeeling/res/maps/synchingFeelingEggMaps.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o SynchingFeeling/o/synchingFeelingGhostTiles.o SynchingFeeling/res/tiles/synchingFeelingGhostTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o SynchingFeeling/o/synchingFeelingGhostMaps.o SynchingFeeling/res/maps/synchingFeelingGhostMaps.c

$GBDK_DIR/bin/png2asset SynchingFeeling/res/sprites/synchingFeelingEggSpr.png -spr8x8 -sw 16 -sh 16 -b 11
$GBDK_DIR/bin/png2asset SynchingFeeling/res/sprites/synchingFeelingBlockSpr.png -spr8x8 -sw 16 -sh 16 -b 11
$GBDK_DIR/bin/png2asset SynchingFeeling/res/sprites/synchingFeelingCoinSpr.png -spr8x8 -sw 16 -sh 16 -b 11
$GBDK_DIR/bin/png2asset SynchingFeeling/res/sprites/synchingFeelingGhostSpr.png -spr8x8 -sw 16 -sh 16 -b 11
$GBDK_DIR/bin/png2asset SynchingFeeling/res/sprites/synchingFeelingEyeSpr.png -spr8x8 -sw 16 -sh 16 -b 11

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o SynchingFeeling/o/synchingFeelingEggMicrogame.o SynchingFeeling/states/synchingFeelingEggMicrogame.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo11 -c -o SynchingFeeling/o/synchingFeelingGhostMicrogame.o SynchingFeeling/states/synchingFeelingGhostMicrogame.c

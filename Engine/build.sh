#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

rm -f Engine/o/*.o
rm -f Engine/o/*.lst
rm -f Engine/o/*.asm
rm -f Engine/o/*.sym

BIN=/Users/dovesam/Documents/Development/gbdk/bin

$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/borderTiles.o Engine/res/tiles/borderTiles.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/fontTiles.o Engine/res/tiles/fontTiles.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/timerTiles.o Engine/res/tiles/timerTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGTiles.o Engine/res/tiles/engineDMGTiles.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat0Map.o Engine/res/maps/engineDMGBat0Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat1Map.o Engine/res/maps/engineDMGBat1Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat2Map.o Engine/res/maps/engineDMGBat2Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat3Map.o Engine/res/maps/engineDMGBat3Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat4Map.o Engine/res/maps/engineDMGBat4Map.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -Wf-bo1 -c -o Engine/o/premgJingle.o Engine/res/audio/premgJingle.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -Wf-bo1 -c -o Engine/o/lostJingle.o Engine/res/audio/lostJingle.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -Wf-bo1 -c -o Engine/o/wonJingle.o Engine/res/audio/wonJingle.c

$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/common.o Engine/common.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/fade.o Engine/fade.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/songPlayer.o Engine/songPlayer.c

$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/microgameData.o Engine/database/microgameData.c

$GBDK_DIR/bin/png2asset Engine/res/sprites/engineGBCart.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 64 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineDMGBezel.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 144 -noflip

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo0 -c -o Engine/o/microgameManagerState.o Engine/states/microgameManagerState.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/titleState.o Engine/states/titleState.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/gameoverState.o Engine/states/gameoverState.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-ba0 -c -o Engine/o/ram.o Engine/ram.c


# @REM During/post gamejam TODO broadstrokes:
# @REM Beautify lobby screen
# @REM    Score increment animation
# @REM    Lives/losing lives animation
# @REM    Speed up/difficulty up animations
# @REM    Transition animation between microgames
# @REM    Make all of the above faster for higher mgSpeed levels
# @REM Title screen
# @REM Saving/loading
# @REM "Overworld map" thingy where you can select MG groups
# @REM Select individual MG screen (grid of MGs, with an icon and byline for each one)
# @REM Maybe: store for unlocking new MGs a la SSBM trophy lottery
# @REM Maybe: if above, a way to earn currency
# @REM Add pausing
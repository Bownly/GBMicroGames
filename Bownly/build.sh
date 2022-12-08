#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

rm -f Bownly/o/*.o
rm -f Bownly/o/*.lst
rm -f Bownly/o/*.asm
rm -f Bownly/o/*.sym

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/sfx.o Bownly/sfx.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyVictoryLapSong.o Bownly/res/audio/bownlyVictoryLapSong.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyTheWhiteSong.o Bownly/res/audio/bownlyTheWhiteSong.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyTheWhite2Song.o Bownly/res/audio/bownlyTheWhite2Song.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyBowBkgTiles.o Bownly/res/tiles/bownlyBowBkgTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5DiceTiles.o Bownly/res/tiles/bownlyMP5DiceTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5HeartTiles.o Bownly/res/tiles/bownlyMP5HeartTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageTiles.o Bownly/res/tiles/bownlyMP5StageTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkgTiles.o Bownly/res/tiles/bownlyPastelBkgTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelHeartTiles.o Bownly/res/tiles/bownlyPastelHeartTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelTreeTiles.o Bownly/res/tiles/bownlyPastelTreeTiles.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5PanelMaps.o Bownly/res/maps/bownlyMP5PanelMaps.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageColMap.o Bownly/res/maps/bownlyMP5StageColMap.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageTopMap.o Bownly/res/maps/bownlyMP5StageTopMap.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkg1Map.o Bownly/res/maps/bownlyPastelBkg1Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkg2Map.o Bownly/res/maps/bownlyPastelBkg2Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkg3Map.o Bownly/res/maps/bownlyPastelBkg3Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelTreeMap.o Bownly/res/maps/bownlyPastelTreeMap.c

$GBDK_DIR/bin/png2asset Bownly/res/sprites/bownlySprArrow.png -spr8x8 -sw 32 -sh 8 -b 2
$GBDK_DIR/bin/png2asset Bownly/res/sprites/bownlySprBow.png -spr8x8 -sw 24 -sh 32 -b 2
$GBDK_DIR/bin/png2asset Bownly/res/sprites/bownlySprTarget.png -spr8x8 -sw 24 -sh 32 -b 2
$GBDK_DIR/bin/png2asset Bownly/res/sprites/bownlySprPastel.png -spr8x8 -sw 32 -sh 32 -b 2 -py 0
$GBDK_DIR/bin/png2asset Bownly/res/sprites/bownlySprJumppuff.png -spr8x8 -sw 16 -b 2 -py 0
$GBDK_DIR/bin/png2asset Bownly/res/sprites/bownlySprPreston.png -spr8x8 -sw 16 -sh 16 -b 2 -py 0 -px 0

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyBowMicrogame.o Bownly/states/bownlyBowMicrogame.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5Microgame.o Bownly/states/bownlyMP5Microgame.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelMicrogame.o Bownly/states/bownlyPastelMicrogame.c

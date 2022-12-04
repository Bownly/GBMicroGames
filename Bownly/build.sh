#!/bin/sh

BIN=/Users/dovesam/Documents/Development/gbdk/bin

echo $BIN

rm Bownly/o/*.o
rm Bownly/o/*.lst
rm Bownly/o/*.asm
rm Bownly/o/*.sym

$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/sfx.o Bownly/sfx.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyVictoryLapSong.o Bownly/res/audio/bownlyVictoryLapSong.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyTheWhiteSong.o Bownly/res/audio/bownlyTheWhiteSong.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyTheWhite2Song.o Bownly/res/audio/bownlyTheWhite2Song.c

$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyBowBkgTiles.o Bownly/res/tiles/bownlyBowBkgTiles.c 
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5DiceTiles.o Bownly/res/tiles/bownlyMP5DiceTiles.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5HeartTiles.o Bownly/res/tiles/bownlyMP5HeartTiles.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageTiles.o Bownly/res/tiles/bownlyMP5StageTiles.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkgTiles.o Bownly/res/tiles/bownlyPastelBkgTiles.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelHeartTiles.o Bownly/res/tiles/bownlyPastelHeartTiles.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelTreeTiles.o Bownly/res/tiles/bownlyPastelTreeTiles.c

$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5PanelMaps.o Bownly/res/maps/bownlyMP5PanelMaps.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageColMap.o Bownly/res/maps/bownlyMP5StageColMap.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageTopMap.o Bownly/res/maps/bownlyMP5StageTopMap.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkg1Map.o Bownly/res/maps/bownlyPastelBkg1Map.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkg2Map.o Bownly/res/maps/bownlyPastelBkg2Map.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkg3Map.o Bownly/res/maps/bownlyPastelBkg3Map.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelTreeMap.o Bownly/res/maps/bownlyPastelTreeMap.c

$BIN/png2asset Bownly/res/sprites/bownlySprArrow.png -spr8x8 -sw 32 -sh 8 -b 2
$BIN/png2asset Bownly/res/sprites/bownlySprBow.png -spr8x8 -sw 24 -sh 32 -b 2
$BIN/png2asset Bownly/res/sprites/bownlySprTarget.png -spr8x8 -sw 24 -sh 32 -b 2
$BIN/png2asset Bownly/res/sprites/bownlySprPastel.png -spr8x8 -sw 32 -sh 32 -b 2 -py 0
$BIN/png2asset Bownly/res/sprites/bownlySprJumppuff.png -spr8x8 -sw 16 -b 2 -py 0
$BIN/png2asset Bownly/res/sprites/bownlySprPreston.png -spr8x8 -sw 16 -sh 16 -b 2 -py 0 -px 0

$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyBowMicrogame.o Bownly/states/bownlyBowMicrogame.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5Microgame.o Bownly/states/bownlyMP5Microgame.c
$BIN/lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelMicrogame.o Bownly/states/bownlyPastelMicrogame.c

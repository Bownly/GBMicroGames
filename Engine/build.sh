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

$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/borderTiles.o Engine/res/tiles/borderTiles.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/fontTiles.o Engine/res/tiles/fontTiles.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/alBhedFontTiles.o Engine/res/tiles/alBhedFontTiles.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/timerTiles.o Engine/res/tiles/timerTiles.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/engineScrollBkgTiles.o Engine/res/tiles/engineScrollBkgTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGTiles.o Engine/res/tiles/engineDMGTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo4 -c -o Engine/o/darkBorderTiles.o Engine/res/tiles/darkBorderTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo4 -c -o Engine/o/engineCursorTiles.o Engine/res/tiles/engineCursorTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo4 -c -o Engine/o/engineMixBorderTiles.o Engine/res/tiles/engineMixBorderTiles.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat0Map.o Engine/res/maps/engineDMGBat0Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat1Map.o Engine/res/maps/engineDMGBat1Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat2Map.o Engine/res/maps/engineDMGBat2Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat3Map.o Engine/res/maps/engineDMGBat3Map.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat4Map.o Engine/res/maps/engineDMGBat4Map.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineSloopygoopResults.o Engine/res/audio/engineSloopygoopResults.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo5 -c -o Engine/o/engineSloopygoopBoogieWoogieEx.o Engine/res/audio/engineSloopygoopBoogieWoogieEx.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo4 -c -o Engine/o/engineSloopygoopPartyTheme.o Engine/res/audio/engineSloopygoopPartyTheme.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo14 -c -o Engine/o/engineLevelUpJingle.o Engine/res/audio/engineLevelUpJingle.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo14 -c -o Engine/o/lostJingle.o Engine/res/audio/lostJingle.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo14 -c -o Engine/o/premgJingle1.o Engine/res/audio/premgJingle1.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo14 -c -o Engine/o/premgJingle2.o Engine/res/audio/premgJingle2.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo14 -c -o Engine/o/premgJingle3.o Engine/res/audio/premgJingle3.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo14 -c -o Engine/o/premgJingle4.o Engine/res/audio/premgJingle4.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo14 -c -o Engine/o/wonJingle.o Engine/res/audio/wonJingle.c

$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/common.o Engine/common.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/fade.o Engine/fade.c
$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/songPlayer.o Engine/songPlayer.c

$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/microgameData.o Engine/database/microgameData.c

$GBDK_DIR/bin/png2asset Engine/res/sprites/engineGBCart.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 64 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineDMGBezel.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 144 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineGBPrinter.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 64 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineGBPrintout.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 96 -noflip

$GBDK_DIR/bin/png2asset Engine/res/sprites/engineTitleCornerGarnish.png -spr8x8 -sw 32 -sh 32 -px 0 -py 0 -b 4
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineTitleLogo.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 48 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineCartArts.png -spr8x8 -sw 16 -sh 16 -b 4 -map -tile_origin 64 -noflip -keep_duplicate_tiles
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineWordPlay.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 48 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineWordRemix.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 80 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineWordCredits.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 128 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineABWordPlay.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 48 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineABWordRemix.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 80 -noflip
$GBDK_DIR/bin/png2asset Engine/res/sprites/engineABWordCredits.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 128 -noflip

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo0 -c -o Engine/o/microgameManagerState.o Engine/states/microgameManagerState.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o Engine/o/gameoverState.o Engine/states/gameoverState.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo4 -c -o Engine/o/titleState.o Engine/states/titleState.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo4 -c -o Engine/o/creditsState.o Engine/states/creditsState.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo4 -c -o Engine/o/deleteSaveState.o Engine/states/deleteSaveState.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo4 -c -o Engine/o/mainMenuState.o Engine/states/mainMenuState.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo4 -c -o Engine/o/remixState.o Engine/states/remixState.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-ba0 -c -o Engine/o/ram.o Engine/ram.c

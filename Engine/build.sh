rm Engine/o/*.o
rm Engine/o/*.lst
rm Engine/o/*.asm
rm Engine/o/*.sym

BIN=/Users/dovesam/Documents/Development/gbdk/bin

$BIN/lcc -Wa-l -c -o Engine/o/borderTiles.o Engine/res/tiles/borderTiles.c
$BIN/lcc -Wa-l -c -o Engine/o/fontTiles.o Engine/res/tiles/fontTiles.c
$BIN/lcc -Wa-l -c -o Engine/o/timerTiles.o Engine/res/tiles/timerTiles.c
$BIN/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGTiles.o Engine/res/tiles/engineDMGTiles.c

$BIN/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat0Map.o Engine/res/maps/engineDMGBat0Map.c
$BIN/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat1Map.o Engine/res/maps/engineDMGBat1Map.c
$BIN/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat2Map.o Engine/res/maps/engineDMGBat2Map.c
$BIN/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat3Map.o Engine/res/maps/engineDMGBat3Map.c
$BIN/lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat4Map.o Engine/res/maps/engineDMGBat4Map.c

$BIN/lcc -Wa-l -Wf-bo1 -Wf-bo1 -c -o Engine/o/premgJingle.o Engine/res/audio/premgJingle.c
$BIN/lcc -Wa-l -Wf-bo1 -Wf-bo1 -c -o Engine/o/lostJingle.o Engine/res/audio/lostJingle.c
$BIN/lcc -Wa-l -Wf-bo1 -Wf-bo1 -c -o Engine/o/wonJingle.o Engine/res/audio/wonJingle.c

$BIN/lcc -Wa-l -c -o Engine/o/common.o Engine/common.c
$BIN/lcc -Wa-l -c -o Engine/o/fade.o Engine/fade.c
$BIN/lcc -Wa-l -c -o Engine/o/songPlayer.o Engine/songPlayer.c

$BIN/lcc -Wa-l -c -o Engine/o/microgameData.o Engine/database/microgameData.c

$BIN/png2asset Engine/res/sprites/engineGBCart.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 64 -noflip
$BIN/png2asset Engine/res/sprites/engineDMGBezel.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 144 -noflip

$BIN/lcc -Wa-l -Wf-bo0 -c -o Engine/o/microgameManagerState.o Engine/states/microgameManagerState.c
$BIN/lcc -Wa-l -Wf-bo1 -c -o Engine/o/titleState.o Engine/states/titleState.c
$BIN/lcc -Wa-l -Wf-bo1 -c -o Engine/o/gameoverState.o Engine/states/gameoverState.c

$BIN/lcc -Wa-l -Wf-ba0 -c -o Engine/o/ram.o Engine/ram.c


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
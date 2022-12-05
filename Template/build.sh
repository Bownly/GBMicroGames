rm Template/o/*.o
rm Template/o/*.lst
rm Template/o/*.asm
rm Template/o/*.sym

BIN=/Users/dovesam/Documents/Development/gbdk/bin


$BIN/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateCursorTiles.o Template/res/tiles/templateCursorTiles.c
$BIN/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFaceTiles.o Template/res/tiles/templateFaceTiles.c

$BIN/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFace1Map.o Template/res/maps/templateFace1Map.c
$BIN/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFace2Map.o Template/res/maps/templateFace2Map.c

$BIN/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateTwilightDriveSong.o Template/res/audio/templateTwilightDriveSong.c

$BIN/lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFaceMicrogame.o Template/states/templateFaceMicrogame.c

# @REM TODO:
# @REM Screenshake?
# @REM sfx
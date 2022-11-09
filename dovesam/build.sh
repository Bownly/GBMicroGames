rm dovesam/o/*.o
rm dovesam/o/*.lst
rm dovesam/o/*.asm
rm dovesam/o/*.sym

BIN=/Users/dovesam/Documents/Development/gbdk/bin
BANK=7
ASSETS=dovesam/res/assets
SPRITES=dovesam/res/sprites
MAPS=dovesam/res/raw_maps

$BIN/lcc -Wa-l -Wf-bo$BANK -c -o dovesam/o/dovesamPaddleMicrogame.o dovesam/states/dovesamPaddleMicrogame.c

$BIN/png2asset $SPRITES/dovesamPaddleSprite.png -spr8x8 -sw 24 -sh 8 -b $BANK -c $ASSETS/dovesamPaddleSprite.c
$BIN/png2asset $SPRITES/dovesamBallSprite.png -spr8x8 -sw 8 -sh 8 -b $BANK -c $ASSETS/dovesamBallSprite.c

$BIN/png2asset $MAPS/dovesamPaddleArena.png -map -noflip -bpp 2 -max_palettes 1 -pack_mode gb -b $BANK -c \
    $ASSETS/dovesamPaddleArena.c

# @REM TODO:
# @REM Screenshake?
# @REM sfx
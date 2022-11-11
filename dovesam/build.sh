rm dovesam/o/*.o
rm dovesam/o/*.lst
rm dovesam/o/*.asm
rm dovesam/o/*.sym
rm dovesam/res/assets/*.c
rm dovesam/res/assets/*.h

BIN=/Users/dovesam/Documents/Development/gbdk/bin
BANK=7
ASSETS=dovesam/res/assets
SPRITES=dovesam/res/sprites
MAPS=dovesam/res/raw_maps

$BIN/png2asset $SPRITES/dovesamPaddleSpriteSheet.png -spr8x8 -sw 32 -sh 8 -b $BANK -c $ASSETS/dovesamPaddleSpriteSheet.c
$BIN/png2asset $SPRITES/dovesamBallSprite.png -spr8x8 -sw 8 -sh 8 -b $BANK -c $ASSETS/dovesamBallSprite.c

$BIN/png2asset $MAPS/dovesamPaddleArena.png -map -noflip -bpp 2 -max_palettes 1 -pack_mode gb -b $BANK -c \
    $ASSETS/dovesamPaddleArena.c

$BIN/lcc -Wa-l -Wf-bo$BANK -c -o dovesam/o/dovesamPaddleMicrogame.o dovesam/states/dovesamPaddleMicrogame.c

# @REM TODO:
# @REM Screenshake?
# @REM sfx
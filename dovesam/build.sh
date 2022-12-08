#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

rm -f dovesam/o/*.o
rm -f dovesam/o/*.lst
rm -f dovesam/o/*.asm
rm -f dovesam/o/*.sym
rm -f dovesam/res/assets/*.c
rm -f dovesam/res/assets/*.h

BANK=7
ASSETS=dovesam/res/assets
SPRITES=dovesam/res/sprites
MAPS=dovesam/res/raw_maps

$GBDK_DIR/bin/png2asset $SPRITES/dovesamPaddleSpriteSheet.png -spr8x8 -sw 32 -sh 8 -b $BANK -c $ASSETS/dovesamPaddleSpriteSheet.c
$GBDK_DIR/bin/png2asset $SPRITES/dovesamBallSprite.png -spr8x8 -sw 8 -sh 8 -b $BANK -c $ASSETS/dovesamBallSprite.c

$GBDK_DIR/bin/png2asset $MAPS/dovesamPaddleArena.png -map -noflip -bpp 2 -max_palettes 1 -pack_mode gb -b $BANK -c \
    $ASSETS/dovesamPaddleArena.c
$GBDK_DIR/bin/png2asset $MAPS/dovesamButtons.png -map -noflip -bpp 2 -max_palettes 1 -pack_mode gb -b $BANK -c $ASSETS/dovesamButtons.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo$BANK -c -o dovesam/o/dovesamPaddleMicrogame.o dovesam/states/dovesamPaddleMicrogame.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo$BANK -c -o dovesam/o/dovesamCodeCrackMicrogame.o dovesam/states/dovesamCodeCrackMicrogame.c

# @REM TODO:
# @REM Screenshake?
# @REM sfx
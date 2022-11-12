del dovesam\o\*.o
del dovesam\o\*.lst
del dovesam\o\*.asm
del dovesam\o\*.sym
del dovesam\res\assets\*.c
del dovesam\res\assets\*.h

set BANK=7
set ASSETS=dovesam/res/assets
set SPRITES=dovesam/res/sprites
set MAPS=dovesam/res/raw_maps

C:\gbdk\bin\png2asset %SPRITES%/dovesamPaddleSpriteSheet.png -spr8x8 -sw 32 -sh 8 -b %BANK% -c %ASSETS%/dovesamPaddleSpriteSheet.c
C:\gbdk\bin\png2asset %SPRITES%/dovesamBallSprite.png -spr8x8 -sw 8 -sh 8 -b %BANK% -c %ASSETS%/dovesamBallSprite.c

C:\gbdk\bin\png2asset %MAPS%/dovesamPaddleArena.png -map -noflip -bpp 2 -max_palettes 1 -pack_mode gb -b %BANK% -c %ASSETS%/dovesamPaddleArena.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo%BANK% -c -o dovesam/o/dovesamPaddleMicrogame.o dovesam/states/dovesamPaddleMicrogame.c
del Template\o\*.o
del Template\o\*.lst
del Template\o\*.asm
del Template\o\*.sym

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateCursorTiles.o Template/res/tiles/templateCursorTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFaceTiles.o Template/res/tiles/templateFaceTiles.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFace1Map.o Template/res/maps/templateFace1Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFace2Map.o Template/res/maps/templateFace2Map.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateTwilightDriveSong.o Template/res/audio/templateTwilightDriveSong.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFaceMicrogame.o Template/states/templateFaceMicrogame.c

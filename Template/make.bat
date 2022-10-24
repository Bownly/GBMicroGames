
@REM mod2gbt Template/res/audio/TheWhite.mod twsong -c 2
@REM del Template\res\audio\outputtwsong.c
@REM rename output.c outputtwsong.c
@REM move outputtwsong.c Template\res\audio

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateCursorTiles.o Template/res/tiles/templateCursorTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFaceTiles.o Template/res/tiles/templateFaceTiles.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFace1Map.o Template/res/maps/templateFace1Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFace2Map.o Template/res/maps/templateFace2Map.c

@REM C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/twsong.o Template/res/audio/outputtwsong.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Template/o/templateFaceMicrogame.o Template/states/templateFaceMicrogame.c

@REM TODO:
@REM Audio
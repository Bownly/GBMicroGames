del Engine\o\*.o
del Engine\o\*.lst
del Engine\o\*.asm
del Engine\o\*.sym

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/borderTiles.o Engine/res/tiles/borderTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/fontTiles.o Engine/res/tiles/fontTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/timerTiles.o Engine/res/tiles/timerTiles.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -Wf-bo1 -c -o Engine/o/premgJingle.o Engine/res/audio/premgJingle.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -Wf-bo1 -c -o Engine/o/lostJingle.o Engine/res/audio/lostJingle.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -Wf-bo1 -c -o Engine/o/wonJingle.o Engine/res/audio/wonJingle.c

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/common.o Engine/common.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/fade.o Engine/fade.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/songPlayer.o Engine/songPlayer.c

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/microgameData.o Engine/database/microgameData.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/microgameData.o Engine/database/microgameData.c


C:\gbdk\bin\lcc -Wa-l -Wf-bo0 -c -o Engine/o/microgameManagerState.o Engine/states/microgameManagerState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/titleState.o Engine/states/titleState.c

c:\gbdk\bin\lcc -Wa-l -Wf-ba0 -c -o Engine/o/ram.o Engine/ram.c


@REM During/post gamejam TODO broadstrokes:
@REM Beautify lobby screen
@REM    Score increment animation
@REM    Lives/losing lives animation
@REM    Speed up/difficulty up animations
@REM    Transition animation between microgames
@REM    Make all of the above faster for higher mgSpeed levels
@REM Title screen
@REM Saving/loading
@REM "Overworld map" thingy where you can select MG groups
@REM Select individual MG screen (grid of MGs, with an icon and byline for each one)
@REM Maybe: store for unlocking new MGs a la SSBM trophy lottery
@REM Maybe: if above, a way to earn currency
@REM Add pausing

del Bownly\o\*.o
del Bownly\o\*.lst
del Bownly\o\*.asm
del Bownly\o\*.sym

@REM  Bank 2 
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/sfx.o Bownly/sfx.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyTheWhiteSong.o Bownly/res/audio/bownlyTheWhiteSong.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyTheWhite2Song.o Bownly/res/audio/bownlyTheWhite2Song.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyBowBkgTiles.o Bownly/res/tiles/bownlyBowBkgTiles.c 
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5DiceTiles.o Bownly/res/tiles/bownlyMP5DiceTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5HeartTiles.o Bownly/res/tiles/bownlyMP5HeartTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageTiles.o Bownly/res/tiles/bownlyMP5StageTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyThingyWallTiles.o Bownly/res/tiles/bownlyThingyWallTiles.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5PanelMaps.o Bownly/res/maps/bownlyMP5PanelMaps.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageColMap.o Bownly/res/maps/bownlyMP5StageColMap.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageTopMap.o Bownly/res/maps/bownlyMP5StageTopMap.c

C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprArrow.png -spr8x8 -sw 32 -sh 8 -b 2
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprBow.png -spr8x8 -sw 24 -sh 32 -b 2
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprTarget.png -spr8x8 -sw 24 -sh 32 -b 2
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprPreston.png -spr8x8 -sw 16 -sh 16 -b 2 -py 0 -px 0
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprBanana.png -spr8x8 -sw 16 -sh 16 -b 2 -py 0
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprThingy.png -spr8x8 -sw 24 -sh 24 -b 2 -py 0

C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyBowMicrogame.o Bownly/states/bownlyBowMicrogame.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5Microgame.o Bownly/states/bownlyMP5Microgame.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyThingyMicrogame.o Bownly/states/bownlyThingyMicrogame.c

@REM Bank 3
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyVictoryLapSong.o Bownly/res/audio/bownlyVictoryLapSong.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelBkgTiles.o Bownly/res/tiles/bownlyPastelBkgTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelHeartTiles.o Bownly/res/tiles/bownlyPastelHeartTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelTreeTiles.o Bownly/res/tiles/bownlyPastelTreeTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelBkg2Tiles.o Bownly/res/tiles/bownlyPastelBkg2Tiles.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelBkg1Map.o Bownly/res/maps/bownlyPastelBkg1Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelBkg2Map.o Bownly/res/maps/bownlyPastelBkg2Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelBkg3Map.o Bownly/res/maps/bownlyPastelBkg3Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelTreeMap.o Bownly/res/maps/bownlyPastelTreeMap.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelCloud1Map.o Bownly/res/maps/bownlyPastelCloud1Map.c

C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprBee.png -spr8x8 -sw 16 -sh 16 -b 3 -py 0
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprPastel.png -spr8x8 -sw 32 -sh 32 -b 3 -py 0
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprJumppuff.png -spr8x8 -sw 16 -b 3 -py 0

C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelHeartsMicrogame.o Bownly/states/bownlyPastelHeartsMicrogame.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelDodgeMicrogame.o Bownly/states/bownlyPastelDodgeMicrogame.c


@REM Thingy TODO:
@REM Thingy eat anim for won
@REM Sfx
@REM Music

@REM Pastel Dodge TODO:
@REM Clean up map 2 and bee placement
@REM Tighten up collision
@REM Spawn bees offscreen
@REM Death anim
@REM Sfx
@REM Music

@REM 
@REM Add o folders !!!!!!
@REM Update readme to mention forking instead of cloning
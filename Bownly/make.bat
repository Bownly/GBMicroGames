
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyBowBkgTiles.o Bownly/res/tiles/bownlyBowBkgTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5DiceTiles.o Bownly/res/tiles/bownlyMP5DiceTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageTiles.o Bownly/res/tiles/bownlyMP5StageTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkgTiles.o Bownly/res/tiles/bownlyPastelBkgTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelHeartTiles.o Bownly/res/tiles/bownlyPastelHeartTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelTreeTiles.o Bownly/res/tiles/bownlyPastelTreeTiles.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5PanelMaps.o Bownly/res/maps/bownlyMP5PanelMaps.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageColMap.o Bownly/res/maps/bownlyMP5StageColMap.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5StageTopMap.o Bownly/res/maps/bownlyMP5StageTopMap.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkg1Map.o Bownly/res/maps/bownlyPastelBkg1Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkg2Map.o Bownly/res/maps/bownlyPastelBkg2Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelBkg3Map.o Bownly/res/maps/bownlyPastelBkg3Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelTreeMap.o Bownly/res/maps/bownlyPastelTreeMap.c

C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprArrow.png -spr8x8 -sw 32 -sh 8 -b 2
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprBow.png -spr8x8 -sw 24 -sh 32 -b 2
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprTarget.png -spr8x8 -sw 24 -sh 32 -b 2
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprPastel.png -spr8x8 -sw 32 -sh 32 -b 2 -py 0
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprJumppuff.png -spr8x8 -sw 16 -b 2 -py 0
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprPreston.png -spr8x8 -sw 16 -sh 16 -b 2 -py 0 -px 0

C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyBowMicrogame.o Bownly/states/bownlyBowMicrogame.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyMP5Microgame.o Bownly/states/bownlyMP5Microgame.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyPastelMicrogame.o Bownly/states/bownlyPastelMicrogame.c


@REM Bow TODO:
@REM Should probably clean up the graphics
@REM Tighten up the physics on level 3
@REM Sfx
@REM Music

@REM Magipanels 5 TODO:
@REM Hearts display
@REM mgSpeed
@REM Sfx
@REM Music

@REM Pastel TODO:
@REM Maybe randomize heart locations?
@REM Sfx
@REM Music


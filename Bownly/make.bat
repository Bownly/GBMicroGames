del Bownly\o\*.o
del Bownly\o\*.lst
del Bownly\o\*.asm
del Bownly\o\*.sym

@REM  Bank 2 
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/sfx.o Bownly/sfx.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyTheWhiteSong.o Bownly/res/audio/bownlyTheWhiteSong.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlyTheWhite2Song.o Bownly/res/audio/bownlyTheWhite2Song.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Bownly/o/bownlySloopygoopBallerinaSong.o Bownly/res/audio/bownlySloopygoopBallerinaSong.c

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
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyKnotAnywhere2Song.o Bownly/res/audio/bownlyKnotAnywhere2Song.c

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

C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyTenseBossBattleSong.o Bownly/res/audio/bownlyTenseBossBattleSong.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelHeartsMicrogame.o Bownly/states/bownlyPastelHeartsMicrogame.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o Bownly/o/bownlyPastelDodgeMicrogame.o Bownly/states/bownlyPastelDodgeMicrogame.c

@REM Bank 9
@REM C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyTireTiles.o Bownly/res/tiles/bownlyTireTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyGrassBkgTiles.o Bownly/res/tiles/bownlyGrassBkgTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyBeronCrownTiles.o Bownly/res/tiles/bownlyBeronCrownTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyBeronMushTiles.o Bownly/res/tiles/bownlyBeronMushTiles.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyBeronCapUpMap.o Bownly/res/maps/bownlyBeronCapUpMap.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyBeronCapDownMap.o Bownly/res/maps/bownlyBeronCapDownMap.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyBeronStalkUpMap.o Bownly/res/maps/bownlyBeronStalkUpMap.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyBeronStalkDownMap.o Bownly/res/maps/bownlyBeronStalkDownMap.c

@REM C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprDrill.png -spr8x8 -sw 8 -sh 8 -b 9 -py 0 -px 0 -sp 16
@REM C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprSophie.png -spr8x8 -sw 24 -sh 24 -b 9 -py 0 -px 0
@REM C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprLizard.png -spr8x8 -sw 16 -sh 24 -b 9
@REM C:\gbdk\bin\png2asset Bownly/res/sprites/bownlyBkgEarth.png -spr8x8 -b 9 -map -tile_origin 48 -noflip
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprRabbit.png -spr8x8 -b 9 -map -tile_origin 48 -noflip
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprCarrot.png -spr8x8 -b 9 -map -tile_origin 160 -noflip
C:\gbdk\bin\png2asset Bownly/res/sprites/bownlySprBeron.png -spr8x8 -sw 16 -sh 16 -b 9 -py 0 -px 0

C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyKnotAnywhere1Song.o Bownly/res/audio/bownlyKnotAnywhere1Song.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlySloopygoopMarioEsqueSong.o Bownly/res/audio/bownlySloopygoopMarioEsqueSong.c

@REM C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyKillerDrillerMicrogame.o Bownly/states/bownlyKillerDrillerMicrogame.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyCarrotMicrogame.o Bownly/states/bownlyCarrotMicrogame.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo9 -c -o Bownly/o/bownlyFlappyBeronMicrogame.o Bownly/states/bownlyFlappyBeronMicrogame.c


@REM Killer Driller TODO:
@REM Animate drill
@REM Render wheels and animate them (stretch goal)
@REM Catch drill
@REM Respawn drill if not caught
@REM Spawn lizards
@REM Killision lizards
@REM MG win
@REM MG lose if lizards escape
@REM Draw buildings
@REM Draw killed buildings if lizards escape
@REM Screenshake
@REM Sfx
@REM Music
